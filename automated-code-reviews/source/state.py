from typing_extensions import Dict, List, Any, TypedDict, Optional


# This defines what information we can store and pass between nodes later
class GraphState(TypedDict):
    """
    Maintains workflow state between agents

    Attributes:
        cloned_repository_path: str - Path to clone repository
        consolidated_code_file_name: str - Consolidated code file name
        cache_name: str - Gemini Cache name
        git_repository_name: str - Git repository name
        git_org_name: str - Git organization name
        git_release_name: str - Git release name
        git_pat: str - Git personal access token
        code_review_file_name: str - Code review file name
        gcs_path_review_file: str - GCS path to review file
    """
    cloned_repository_path: str
    consolidated_code_file_name: str
    cache_name: str
    git_repository_name: str
    git_org_name: str
    git_release_name: str
    git_pat: str
    code_review_file_name: str
    gcs_path_review_file: str
