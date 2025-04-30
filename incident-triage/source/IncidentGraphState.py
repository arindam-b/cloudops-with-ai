from typing_extensions import Dict, List, Any, TypedDict, Optional


# This defines what information we can store and pass between nodes later
class GraphState(TypedDict):
    """
    Maintains workflow state between agents

    Attributes:
        incident_data: Dict : Incident Data information from GCP Alert monitoring
        resolution_suggested: str : Category of query
        searched_data: List[str] : Sentiment of query
        incident_search_query: str : Query to search for solutions
        is_custom_metrics: bool : Whether the incident comes from a custom metrics
    """
    incident_data: Dict
    resolution_suggested: str
    searched_data: List[Dict]
    incident_search_query: str
    is_custom_metrics: bool    
