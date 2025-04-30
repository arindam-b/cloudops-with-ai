from flask import Flask, request
import os, base64, json, requests
import vertexai
import Workflow


PROJECT_ID = os.environ["PROJECT_ID"]
REGION = os.environ["REGION"]
URL = os.environ["MSTEAMS_WEBHOOK_URL"]
TAVILY_API_KEY = os.environ["TAVILY_API_KEY"]

vertexai.init(project=PROJECT_ID, location=REGION)


app = Flask(__name__)


# Send webhook notification on teams
def send_teams(content:str, title:str) -> int:
    """
      - Send a teams notification to the desired webhook_url
      - Returns the status code of the HTTP request
        - webhook_url : MS Teams webhook url
        - content : alert formatted notification content
        - title : the message that'll be displayed as title        
    """
    color = "#f5425a"

    response = requests.post(
        url=URL,
        headers={"Content-Type": "application/json"},
        json={
            "themeColor": color,
            "summary": title,
            "sections": [{
                "activityTitle": title,
                "activitySubtitle": content
            }],
        },
    )
    return response.status_code


@app.route("/", methods=['POST'])
def process_incident():
    envelope = request.get_json()

    if not envelope:
        msg = "no Pub/Sub message received"
        print(f"error: {msg}")
        return f"Bad Request: {msg}", 400

    pubsub_message = envelope["message"]

    print(f"Received pubsub message: {pubsub_message}")

    payload = ""

    if isinstance(pubsub_message, dict) and "data" in pubsub_message:
        main_message = base64.b64decode(pubsub_message["data"]).decode("utf-8").strip()
        payload = json.loads(main_message)
        print(f"Received payload: {payload}")

    try:
        if payload["incident"]["incident_id"] == "heartbeat":
            print("heartbeat message.")
            return ("ignore.", 200)
        else:
            title=f'GCP Incident: {payload["incident"]["policy_name"]}'
            policy_name = payload["incident"]["policy_name"]
            type = payload["incident"]["resource"]["type"]
            metric = payload["incident"]["metric"]["displayName"]
            observed_value = payload["incident"]["observed_value"]
            threshold = payload["incident"]["threshold_value"]
            metric_label = payload["incident"]["metric"]["labels"]
            summary = payload["incident"]["summary"]

            incident_data = {
                "type": type,
                "metric": metric,
                "metric_label": str(metric_label),
                "observed_value": observed_value,
                "threshold": threshold,
                "policy_name": policy_name,
                "summary": summary
            }
            # Initialize and run workflow
            workflow = Workflow.create_workflow()

            final_state = workflow.invoke({
                "incident_data": incident_data,
                "resolution_suggested": None,
                "searched_data": None,
                "incident_search_query": None
            })
            
            resolution_suggested = final_state["resolution_suggested"]
            searched_data = final_state["searched_data"]
            content = ""
            if len(searched_data) > 0:
                content = f"Resolution: {resolution_suggested}\n\nSearch Results:\n"
                for data in searched_data:
                    content += f"URL: {data['url']}\n Content: {data['content']}\n\n"
            else:
                content = f"Resolution: {resolution_suggested}"

            print(content)
            send_teams(content, title)
        
    except Exception as e:
        print(e)
        raise e

    return ("alert-sent.", 204)


if __name__ == "__main__":
    app.run(host="0.0.0.0", debug=True)