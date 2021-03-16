# Frontend project

This project uses a docker, travis ci and aws, to deploy a new version of the project when a change is made over the master branch.

### AWS

It uses Elastic Beanstalk, and the application is deployed in a S3.

Due possible billings, the application on Elastic Beanstalk was deleted. If it is created again in the future, you should change the following fields of the .travis.yml.
- region: By the region where the bucket is
- app: By the name of the app
- env: By the name of the environment
- bucket_name: By the bucket name

Also the .travis.yml file located in the 04-frontend folder, should be moved to the root of this repository.