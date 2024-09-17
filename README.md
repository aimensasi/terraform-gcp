## Terraform For GCP

### Setup 
1. Create Github Repo
2. Enable Cloud Build App
3. Create GCP Account
4. Enable `Cloud Resource Manager API` 
5. Enable Billing Account
4. Create Service Key and add it to github secrets
5. Create a storage bucket to be used by terraform to store state
6. Set Docker host variable



Next step, this setup assumes that everytime we need to add a new project
We will need to clone and run the entire thing again, but this is not correct
We need to identifies shared services vs project based service
For example cloud build trigger will be project based
DB is shared
Bucket might be both
Cloud Run is project based


## Checklist
1. Cloud SQL [DONE]
2. Bucket [DONE]
