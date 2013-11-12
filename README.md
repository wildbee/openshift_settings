Openshift Settings
==================
This repo will contain the necessary settings to deploy the wildbee application to an openshift instance

## Instructions
```bash
rhc create-app <project> diy-0.1
cd <project>

# add PostgreSQL cartridge
rhc cartridge-add -a <project>  -c postgresql-9.2

# delete the default openshift settings and get the custom openshift settings
that will work with Play
rm -r .openshift
git clone https://github.com/wildbee/openshift_settings.git .openshift

# push to openshift and run
sh .openshift/deploy.sh <path_of_wildbee_repo>
```

## FAQ
- Why don't we compile the Play code in Openshift?

Openshift has a 512 MB memory limit. When attempting to compile the code in
Openshift, Java needs more than 512 MB of memory and the Openshift memory
manager will kill the Java process.

- Where is all the magic happening?

See `action_hooks/start` to see what's happening.

## Useful `rhc` commands
```bash
# To ssh to the gear where your app is deployed
rhc app ssh

# To see info about your gear/app
rhc app show
```
