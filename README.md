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

