# demo
This project seeks to deploy both a ci/cd pipeline for developing a Superset service, as well as a running copy of the service.

To deploy this project in a new environment, first comment out the "backend" block from provider.tf  and then run terraform init / terraform apply.

Once complete, then uncomment the "backend" block from provider.tf and re-run terraform init/apply.  This will migrate the state from your local machine to the cloud.

Create a "Personal Access Token" in github and populate the secret "github/credentials" with it's value.

Once complete, the Codepipeline will automatically detect any changes to the repo and deploy them to the environment.

TODO:
Cleanup terraform files.
Migrate to cognito oauth (ran out of time)
Clean user permissions.
