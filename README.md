# java-inetaddress

Sample application to test UnknownHostException

## OpenShift

### Deploying

To deploy to OpenShift:

1) `oc new-app https://github.com/stakater/java-inetaddress --name=route-test-app`

_NOTE_: if you change the name of the app i.e. `route-test-app` then please ensure to update in the following commands as well.

2) `oc set env dc/route-test-app TEST_HOSTNAME=app.stakater.com`

3) `oc set env dc/route-test-app DELAY=1` # Set 1s delay between each DNS lookup.

4) `oc scale dc/route-test-app --replicas=5` # Scale up to increase probability of failure.

6) Use this to quickly check logs on all the running pods:

```
for pod in $(oc get pods -l app=route-test-app  | grep route-test-app | awk '{print $1}'); do echo $pod; oc logs $pod; done
```

7) The app will print out `UnknownHostException` along with the time when it occurred.

### Cleanup

```
oc delete all -l app=route-test-app
```

`oc new-app` labels everything that it creates, by default with `app=<generated name>`. You can use `-l` to customise the label(s) added to create resources. To delete, do `oc delete all -l app=<generated name>` (or whatever labels you set).
