# Multi Container App with Kubernetes

The main idea of this project is to migrate the previous created [Multi Container App inside the 05-complex folder](../05-complex/README.md), to Kubernetes.

Some parts of this project have to be done in Github instead of [Gitlab](https://gitlab.com/lhbelfanti/dokub) due Gitlab support for Travis CLI.

## Objective:
![Multi Container App with Kubernetes](./objective.png)

## ingress-nginx

This project uses ingress-nginx. To 'install' it:

`kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.44.0/deploy/static/provider/cloud/deploy.yaml`

## Installing Kubernetes Dashboard

1. curl https://raw.githubusercontent.com/kubernetes/dashboard/v2.2.0/aio/deploy/recommended.yaml > kubernetes-dashboard.yaml
2.  Open up the downloaded file in your code editor and use CMD+F or CTL+F to find the args. Add the following two lines underneath --auto-generate-certificates:

```
args:
  - --auto-generate-certificates
  - --enable-skip-login
  - --disable-settings-authorizer
```
3. Run the following command inside the directory where you downloaded the dashboard manifest file a few steps ago:

`kubectl apply -f kubernetes-dashboard.yaml`

4. Start the server by running the following command:

`kubectl proxy`

5. You can now access the dashboard by visiting:

http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/

6. You will be presented with a login screen, click the "SKIP" link next to the SIGN IN button.

7. You should now be redirected to the Kubernetes Dashboard.

**Important!** The only reason we are bypassing RBAC Authorization to access the Kubernetes Dashboard is that we are running our cluster locally. You would never do this on a public-facing server like Digital Ocean and would need to refer to the official docs to get the dashboard setup.

If you wish to instead create a sample user, you can follow the instructions here:

https://github.com/kubernetes/dashboard/blob/master/docs/user/access-control/creating-sample-user.md


## GKE creation steps
1. Click the Hamburger menu on the top left-hand side of the dashboard.
2. Click Kubernetes Engine.
3. Click the ENABLE button to enable the Kubernetes API for this project.
4. After a few minutes of waiting, clicking the bell icon in the top right part of the menu should show a green checkmark for Enable services: container.googleapis.com
5. If you refresh the page it should show a screen to create your first cluster. If not, click the hamburger menu and select Kubernetes Engine and then Clusters.
Once you see the screen below, click the CREATE button.
6. A Create Cluster dialog will open and provide two choices. Standard and Autopilot. Click the CONFIGURE button within the Standard cluster option.
7. A form will be shown. 
  1. Set the Name to multi-cluster. 
  2. Confirm that the Zone set is actually near your location. 
  3. The Node Pool is found in a separate dropdown on the left sidebar. Click the downward-facing arrow to view the settings. No changes are needed here. 
  4. Finally, click the CREATE button at the bottom of the form.
8. After a few minutes, the cluster dashboard should load and your multi-cluster should have a green checkmark in the table.

## Service Account steps for new GCP UI
1. Click the Hamburger menu on the top left-hand side of the dashboard, find IAM & Admin, and select Service Accounts. Then click the CREATE SERVICE ACCOUNT button.
2. In the form that is displayed, set the Service account name to travis-deployer, then click the CREATE button.
3. Click in the Select a role filter and scroll down to select Kubernetes Engine and then Kubernetes Engine Admin.
4. Make sure the filter now shows Kubernetes Engine Admin and then click CONTINUE.
5. The Grant users access form is optional and should be skipped. Click the DONE button.
6. You should now see a table listing all of the service accounts including the one that was just created. Click the three dots to the right of the service account you just created. Then select Manage Keys in the dropdown.
7. In the Keys dashboard, click ADD KEY and then select Create new key.
8. In the Create private key dialog box, make sure Key type is set to JSON, and then click the CREATE button.
9. The JSON key file should now download to your computer.

> **_NOTE:_** If the Kubernetes server is created again in the future, you should follow the [GKE creation steps](#gke-creation-steps), the [Service Account steps for new GCP UI](#service-account-steps-for-new-gcp-ui) and the **.travis.yml** file located in the 07-complex-with-k8s folder, should be moved to the root of this repository.