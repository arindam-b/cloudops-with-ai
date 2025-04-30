from fastapi import FastAPI
import uvicorn, vertexai
import os
import graph


app = FastAPI()


project_id = os.environ["project_id"]
location = os.environ["location"]
local_path = os.environ['local_directory']

vertexai.init(project=project_id, location=location)


@app.get("/")
def read_root():
    return {"Health-Check": "OK"}


@app.get("/{org_name}/{repository_name}/{release_name}")
async def code_review(org_name: str,repository_name: str, release_name: str):
    
    input_data = {
        "git_org_name": org_name.strip(),
        "git_repository_name": repository_name.strip(),
        "git_release_name": release_name.strip()
    }

    workflow = graph.create_workflow()

    final_state = workflow.invoke(input_data)

    print(f"Code review completed for {repository_name} release {release_name}")
    print(f"Code review report: {final_state}")
    print(final_state.get("gcs_path_review_file"))

    return "OK"


if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8080)

