## Terraform For GCP

### Setup 
1. Create Github Repo
2. Enable Cloud Build App
3. Create GCP Account
4. Enable `Cloud Resource Manager API` 
5. Enable Billing Account
4. Create Service Key and add it to github secrets
5. Create a storage bucket and add the name to the environment variable called GOOGLE_CREDENTIALS, 
    terraform will look for this variable for credentials
6. Set Docker host variable