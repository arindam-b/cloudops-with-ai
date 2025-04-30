# Cloud Operations with AI - Google Agentic Hackathon Submission

This repository contains projects developed for the Google Agentic Hackathon, focusing on leveraging Generative AI, specifically Gemini models and LangGraph, to enhance Cloud Operations (CloudOps).

## Projects

This submission includes two main agentic solutions:

### 1. Automated Code Reviews (`automated-code-reviews/`)

*   **Introduction:** This project implements an automated code review workflow triggered by new releases in Git repositories (GitHub/GitLab). It utilizes a LangGraph agent running on Cloud Run, powered by Gemini 1.5 Pro. The agent clones the repository, consolidates the code, caches it using Gemini Caching, performs a review based on a predefined questionnaire ([automated-code-reviews/source/questionnaires.json](automated-code-reviews/source/questionnaires.json)) covering coding, security, and testing best practices, and finally uploads a detailed report (`.docx`) to Google Cloud Storage.
*   **Key Benefits & ROI:**
    *   **Consistency:** Ensures consistent application of coding standards and best practices across all reviews.
    *   **Speed:** Significantly reduces the time required for manual code reviews, accelerating the development lifecycle.
    *   **Efficiency:** Frees up developer time from routine review tasks, allowing them to focus on more complex problem-solving.
    *   **Early Bug Detection:** Helps identify potential issues, security vulnerabilities, and bad practices early in the development cycle, reducing the cost of fixing them later.
    *   **Improved Code Quality:** Leads to higher quality, more maintainable, and more secure codebases over time.
*   **Detailed Documentation:** For deployment instructions, technical details, and usage, please refer to the [automated-code-reviews/README.md](automated-code-reviews/README.md).

### 2. Incident Triage (`incident-triage/`)

*   **Introduction:** This solution automates the initial triage of incidents triggered by monitoring alerts (e.g., from Google Cloud Monitoring). An agent, deployed on Cloud Run and built with LangGraph and Gemini 1.5 Pro, receives alerts via Pub/Sub. It analyzes the incident data, distinguishes between standard and custom metrics ([incident-triage/source/Workflow.py](incident-triage/source/Workflow.py)), suggests potential resolutions using Gemini's reasoning capabilities, summarizes the incident, searches the internet for relevant troubleshooting guides using the Tavily API ([incident-triage/source/Models.py](incident-triage/source/Models.py)), and sends a consolidated report (including analysis, suggested resolution, and search results) to a notification channel like Microsoft Teams ([incident-triage/source/app.py](incident-triage/source/app.py)).
*   **Key Benefits & ROI:**
    *   **Faster Response:** Reduces Mean Time To Acknowledge (MTTA) and Mean Time To Resolve (MTTR) by automating initial analysis and information gathering.
    *   **Reduced Alert Fatigue:** Filters and prioritizes alerts, providing context and potential solutions, thus reducing noise for on-call engineers.
    *   **Improved Accuracy:** Leverages AI to analyze incident data and suggest relevant solutions, potentially reducing human error in initial diagnosis.
    *   **Knowledge Augmentation:** Provides engineers with relevant external documentation and potential fixes directly within the alert notification.
    *   **Operational Efficiency:** Automates repetitive triage tasks, allowing Ops teams to focus on resolving complex issues and proactive improvements.
*   **Detailed Documentation:** For architecture details, deployment steps (using Terraform), and configuration, please see the [incident-triage/README.md](incident-triage/README.md).

---

For specific details on each project, including setup, deployment, and usage, please navigate to the respective project directories.