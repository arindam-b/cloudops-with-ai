# Veirfy the incident to check if belongs to a custom metric
# Incident verification mode

import os
from IncidentGraphState import GraphState
from langchain_core.prompts import ChatPromptTemplate
from langchain_google_vertexai import VertexAI, ChatVertexAI
from Models import ResolutionSearcher
from langgraph.graph import StateGraph, START, END


CUSTOM_POLICY_NAME_PREFIX = os.environ.get("CUSTOM_POLICY_NAME_PREFIX")
llm = ChatVertexAI(model_name="gemini-1.5-pro-002", temperature=0)


# Veirfy the incident to check if belongs to a custom metric
# Incident verification mode
def verify_incident(state: GraphState) -> GraphState:
    """Verify the incident to check if belongs to a custom metric"""
    incident_data = state["incident_data"]
    policy_name = incident_data["policy_name"]


    if policy_name.startswith(CUSTOM_POLICY_NAME_PREFIX):
      print("Custom metric")
      state["is_custom_metrics"] = True
    else:
      print("Not a custom metric")
      state["is_custom_metrics"] = False
    return state


# Routing node to direct the traffic based on metric type

def route_query(state: GraphState) -> str:
    """Route the query based is_custom_metrics flag"""
    if state["is_custom_metrics"]:
        return "treat_incident_custom_metric"
    else:
        return "analyze_incident"


def treat_incident_custom_metric(state: GraphState) -> GraphState:
    """Treat the incident if it belongs to a custom metric.
       Here the plan of actions are to be customized based on different
       user defined metrics.
    """
    state["incident_search_query"] = "NOT_APPLICABLE"

    # Here the implementation node for the custom actions

    state["resolution_suggested"] = "Based on the custom metrics, action should be done."
    state["searched_data"] = []

    return state


# Ask LLM for a resolutions
# Resolution finding node


def analyze_incident(state: GraphState) -> GraphState:
    """Analyze the GCP alert raised by GCP Monitoring and summarize the incident
     to search for solutions in the internet"""
    incident_data = state["incident_data"]
    prompt = ChatPromptTemplate.from_template(
        """You are a Google Cloud expert DevSecOps engineer. Analyze the
        following incident and provide the solution
            Incident details:
           - Type: {type}
           - Metric: {metric}
           - Metric Label: {metric_label}
           - Observed value: {observed_value}
           - Threshold: {threshold}
           - Summary: {summary}"""
    )

    try:
        chain = prompt | llm
        resolution = chain.invoke(incident_data).content

        state["resolution_suggested"] = resolution

        return state

    except Exception as e:
        state["resolution_suggested"] = "Error encountered while analyzing the incident"
        return state


# Ask LLM to summarize the incident
# Summarization node


def summarization_node(state: GraphState) -> GraphState:
    """Analyze the GCP alert raised by GCP Monitoring and summarize the incident
     to search for solutions in the internet"""
    incident_data = state["incident_data"]

    prompt = ChatPromptTemplate.from_template(
        """You are a Google Cloud expert DevSecOps engineer. Analyze the
        following incident and prepare a search query for the problem statement in a very few words,
        to find solutions for the incident in the internet.
            Incident details:
           - Type: {type}
           - Metric: {metric}
           - Metric Label: {metric_label}
           - Observed value: {observed_value}
           - Threshold: {threshold}
           - Summary: {summary}"""
    )

    try:
        chain = prompt | llm
        incident_search_query = chain.invoke(incident_data).content

        state["incident_search_query"] = incident_search_query

        return state

    except Exception as e:
        state["incident_search_query"] = "Error encountered while summarizing the incident"
        return state


# Search node

def search(state: GraphState) -> GraphState:
    """Based on the summarized information, search internet to have
       probable solution for incident
    """
    incident_search_query = state["incident_search_query"]

    searched_data = []

    searcher = ResolutionSearcher()
    try:
        searched_data = searcher.search(incident_search_query)
        state["searched_data"] = searched_data

        return state

    except Exception as e:
        state["searched_data"] = "Error encountered while searching for solutions"
        return state


def create_workflow() -> StateGraph:
    """
    Constructs and configures the workflow graph
    search -> summarize -> publish

    Returns:
        StateGraph: Compiled workflow ready for execution
    """

    # Create a workflow (graph) initialized with our state schema
    workflow = StateGraph(state_schema=GraphState)

    # Add processing nodes that we will flow between
    workflow.add_node("verify_incident", verify_incident)
    workflow.add_node("treat_incident_custom_metric", treat_incident_custom_metric)
    workflow.add_node("analyze_incident", analyze_incident)
    workflow.add_node("summarization_node", summarization_node)
    workflow.add_node("search", search)

    workflow.add_conditional_edges("verify_incident",
                                   route_query,
                                   {
                                       "analyze_incident": "analyze_incident",
                                       "treat_incident_custom_metric":  "treat_incident_custom_metric"
                                   }
                                   )

    # Define the flow with edges
    workflow.add_edge("analyze_incident", "summarization_node")
    workflow.add_edge("summarization_node", "search")
    workflow.add_edge("search", END)
    workflow.add_edge("treat_incident_custom_metric", END)

    # Set where to start
    workflow.set_entry_point("verify_incident")

    return workflow.compile()
