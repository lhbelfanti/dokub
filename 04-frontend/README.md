# Frontend project

This project uses a Docker, Travis CI and AWS, to build the project, run the tests and deploy a new version of it when a change is made over the master branch.

It uses the [Dockerfile.dev](./Dockerfile.dev) to run the tests and the [Dockerfile](./Dockerfile) is used by the AWS bucket to show the app.
The [.travis.yml](./.travis.yml) file is in charge of the deployment to AWS.

## AWS

It uses Elastic Beanstalk, and the application is deployed in a S3.

Due possible billings, the application on Elastic Beanstalk was deleted. 

> **_NOTE:_** If the bucket is created again in the future, you should follow the [AWS Configuration Cheat Sheet](#aws-configuration-cheat-sheet) and the .travis.yml file located in the 04-frontend folder, should be moved to the root of this repository.


## AWS Configuration Cheat Sheet

### Initial Setup

1. Go to AWS Management Console
2. Search for Elastic Beanstalk in "Find Services"
3. Click the "Create Application" button
4. Enter "docker" for the Application Name
5. Scroll down to "Platform" and select "Docker" from the dropdown list.
6. Change "Platform Branch" to Docker running on 64bit Amazon Linux
7. Click "Create Application"
8. You should see a green checkmark after some time.
9. Click the link above the checkmark for your application. This should open the application in your browser and display a Congratulations message.

### Add AWS configuration details to .travis.yml file's deploy script

1. Set the region. The region code can be found by clicking the region in the toolbar next to your username.
> `eg: 'us-east-1'`
2. app should be set to the Application Name (Step #4 in the Initial Setup above)
> `eg: 'docker'`
3. env should be set to the lower case of your Beanstalk Environment name.
> `eg: 'docker-env'`
4. Set the bucket_name. This can be found by searching for the S3 Storage service. Click the link for the elasticbeanstalk bucket that matches your region code and copy the name.
> `eg: 'elasticbeanstalk-us-east-1-923445599289'`
5. Set the bucket_path to 'docker'
6. Set access_key_id to $AWS_ACCESS_KEY
7. Set secret_access_key to $AWS_SECRET_KEY

### Create an IAM User

1. Search for the "IAM Security, Identity & Compliance Service"
2. Click "Create Individual IAM Users" and click "Manage Users"
3. Click "Add User"
4. Enter any name you’d like in the "User Name" field.
> `eg: docker-react-travis-ci`
5. Tick the "Programmatic Access" checkbox
6. Click "Next:Permissions"
7. Click "Attach Existing Policies Directly"
8. Search for "beanstalk"
9. Tick the box next to "AWSElasticBeanstalkFullAccess"
10. Click "Next:Tags"
11. Click "Next:Review"
12. Click "Create user"
13. Copy and / or download the Access Key ID and Secret Access Key to use in the Travis Variable Setup.

### Travis Variable Setup

1. Go to your Travis Dashboard and find the project repository for the application we are working on.
2. On the repository page, click "More Options" and then "Settings"
3. Create an AWS_ACCESS_KEY variable and paste your IAM access key from step #13 above.
4. Create an AWS_SECRET_KEY variable and paste your IAM secret key from step #13 above.


### Deploying App

1. Make any change to a file in the project, commit and push it to master branch.
2. Go to your Travis Dashboard and check the status of your build.
3. The status should eventually return with a green checkmark and show "build passing"
4. Go to your AWS Elasticbeanstalk application
5. It should say "Elastic Beanstalk is updating your environment"
6. It should eventually show a green checkmark under "Health". You will now be able to access your application at the external URL provided under the environment name.