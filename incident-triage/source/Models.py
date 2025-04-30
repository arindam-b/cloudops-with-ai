from pydantic import BaseModel
from langchain_community.tools import TavilySearchResults
from typing_extensions import List



# Incident resolution Searcher agent - search internet via Tavily api
class ResolutionSearcher:
    """
    Agent responsible for finding relevant information in the internet
    on devops incident resolution using the Tavily search API
    """
    def __init__(self):
        self.tool = TavilySearchResults(
            max_results=2,
            search_depth="advanced",
            include_answer=True,
            include_raw_content=True,
            include_images=True,
        )

    def search(self, search_query: str) -> List:
        """
        Performs news search with configured parameters

        Returns:
            List[]: Collection of found search results
        """

        search_result = self.tool.invoke({"query": "`gce instance high CPU utilization`"})

        return search_result
