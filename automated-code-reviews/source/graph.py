from langgraph.graph import START, END, StateGraph
from state import GraphState
from tools import clone_repository, read_repository_contents
from tools import caching_contents, prepare_code_review, upload_file


def create_workflow() -> StateGraph:

    # Add nodes and edges
    builder = StateGraph(GraphState)
    builder.add_node("clone_repository", clone_repository)
    builder.add_node("read_repository_contents", read_repository_contents)
    builder.add_node("caching_contents", caching_contents)
    builder.add_node("prepare_code_review", prepare_code_review)
    builder.add_node("upload_file", upload_file)

    builder.add_edge(START, "clone_repository")
    builder.add_edge("clone_repository", "read_repository_contents")
    builder.add_edge("read_repository_contents", "caching_contents")
    builder.add_edge("caching_contents", "prepare_code_review")
    builder.add_edge("prepare_code_review", "upload_file")
    builder.add_edge("upload_file", END)


    graph = builder.compile()

    return graph
