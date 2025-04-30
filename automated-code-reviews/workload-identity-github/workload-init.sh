#!/bin/sh

export PROJECT_ID="prj-p-eden"

export PROJECT_NUMBER="1024257324482"

export POOL_NAME="wi-pool"

export PROVIDER_NAME="wi-provider"

export SERVICE_ACCOUNT="edenworkloadidentity"

export ORG_NAME="arindam-b"

gcloud config set project $PROJECT_ID

gcloud iam workload-identity-pools create "${POOL_NAME}" \
  --project="${PROJECT_ID}" \
  --location="global" \
  --display-name="${POOL_NAME}"

gcloud iam service-accounts create "${SERVICE_ACCOUNT}" \
    --description="${SERVICE_ACCOUNT}" \
    --display-name="${SERVICE_ACCOUNT}"

gcloud iam workload-identity-pools providers create-oidc "${PROVIDER_NAME}" \
    --location="global" \
    --workload-identity-pool="${POOL_NAME}" \
    --issuer-uri="https://token.actions.githubusercontent.com/" \
    --attribute-mapping="google.subject=assertion.sub,attribute.actor=assertion.actor,attribute.aud=assertion.aud,attribute.repository=assertion.repository" \
    --attribute-condition="assertion.repository_owner=='${ORG_NAME}'"

gcloud projects add-iam-policy-binding "${PROJECT_ID}" \
    --member "serviceAccount:${SERVICE_ACCOUNT}@${PROJECT_ID}.iam.gserviceaccount.com" \
    --role "roles/artifactregistry.writer" \
    --condition='expression=request.time < timestamp("2100-01-01T00:00:00Z"),title=expires_end_of_2100,description=Expires at midnight on 2100-01-01'

gcloud projects add-iam-policy-binding "${PROJECT_ID}" \
    --member "serviceAccount:${SERVICE_ACCOUNT}@${PROJECT_ID}.iam.gserviceaccount.com" \
    --role "roles/storage.objectAdmin" \
    --condition='expression=request.time < timestamp("2100-01-01T00:00:00Z"),title=expires_end_of_2100,description=Expires at midnight on 2100-01-01'

gcloud projects add-iam-policy-binding "${PROJECT_ID}" \
    --member "serviceAccount:${SERVICE_ACCOUNT}@${PROJECT_ID}.iam.gserviceaccount.com" \
    --role "roles/run.invoker" \
    --condition='expression=request.time < timestamp("2100-01-01T00:00:00Z"),title=expires_end_of_2100,description=Expires at midnight on 2100-01-01'

gcloud projects add-iam-policy-binding "${PROJECT_ID}" \
    --member "serviceAccount:${SERVICE_ACCOUNT}@${PROJECT_ID}.iam.gserviceaccount.com" \
    --role "roles/serviceconsumermanagement.tenancyUnitsAdmin" \
    --condition='expression=request.time < timestamp("2100-01-01T00:00:00Z"),title=expires_end_of_2100,description=Expires at midnight on 2100-01-01'

gcloud projects add-iam-policy-binding "${PROJECT_ID}" \
    --member "serviceAccount:${SERVICE_ACCOUNT}@${PROJECT_ID}.iam.gserviceaccount.com" \
    --role "roles/iam.serviceAccountUser" \
    --condition='expression=request.time < timestamp("2100-01-01T00:00:00Z"),title=expires_end_of_2100,description=Expires at midnight on 2100-01-01'

gcloud projects add-iam-policy-binding "${PROJECT_ID}" \
    --member "serviceAccount:${SERVICE_ACCOUNT}@${PROJECT_ID}.iam.gserviceaccount.com" \
    --role "roles/storage.admin" \
    --condition='expression=request.time < timestamp("2100-01-01T00:00:00Z"),title=expires_end_of_2100,description=Expires at midnight on 2100-01-01'

gcloud projects add-iam-policy-binding "${PROJECT_ID}" \
    --member "serviceAccount:${SERVICE_ACCOUNT}@${PROJECT_ID}.iam.gserviceaccount.com" \
    --role "roles/cloudbuild.builds.editor" \
    --condition='expression=request.time < timestamp("2100-01-01T00:00:00Z"),title=expires_end_of_2100,description=Expires at midnight on 2100-01-01'

gcloud projects add-iam-policy-binding "${PROJECT_ID}" \
    --member "serviceAccount:${SERVICE_ACCOUNT}@${PROJECT_ID}.iam.gserviceaccount.com" \
    --role "roles/appengine.appAdmin" \
    --condition='expression=request.time < timestamp("2100-01-01T00:00:00Z"),title=expires_end_of_2100,description=Expires at midnight on 2100-01-01'

export REPOSITORY="api_repository"

gcloud iam service-accounts add-iam-policy-binding "${SERVICE_ACCOUNT}@${PROJECT_ID}.iam.gserviceaccount.com" \
  --project="${PROJECT_ID}" \
  --role="roles/iam.workloadIdentityUser" \
  --member="principalSet://iam.googleapis.com/projects/${PROJECT_NUMBER}/locations/global/workloadIdentityPools/${POOL_NAME}/attribute.repository/${ORG_NAME}/${REPOSITORY}"

export REPOSITORY="atos_aiassistant"

gcloud iam service-accounts add-iam-policy-binding "${SERVICE_ACCOUNT}@${PROJECT_ID}.iam.gserviceaccount.com" \
  --project="${PROJECT_ID}" \
  --role="roles/iam.workloadIdentityUser" \
  --member="principalSet://iam.googleapis.com/projects/${PROJECT_NUMBER}/locations/global/workloadIdentityPools/${POOL_NAME}/attribute.repository/${ORG_NAME}/${REPOSITORY}"
