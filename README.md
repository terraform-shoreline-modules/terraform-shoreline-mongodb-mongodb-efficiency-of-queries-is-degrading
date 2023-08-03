
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# MongoDB Efficiency of queries is degrading
---

This incident type describes an issue where the efficiency of queries in MongoDB is degrading. The incident may be triggered by an alert monitoring system that detects an anomaly in the performance of queries executed in the database. The incident may result in a decrease in system performance and may require the attention of a software engineer to troubleshoot and resolve the issue.

### Parameters
```shell
# Environment Variables

export COLLECTION="PLACEHOLDER"

export DATABASE="PLACEHOLDER"

export MONGODB_HOST="PLACEHOLDER"

export MONGODB_USER="PLACEHOLDER"

export MONGODB_PORT="PLACEHOLDER"

export MONGODB_PASSWORD="PLACEHOLDER"

```

## Debug

### First, let's check if the MongoDB instance is running
```shell
systemctl status mongodb
```

### If the instance is running, check the logs for any errors
```shell
journalctl -u mongodb --since "10 minutes ago"
```

### Check if the MongoDB queries are taking longer than usual (replace <database> and <collection> with the relevant names)
```shell
mongo ${DATABASE} --eval "db.${COLLECTION}.find().explain('executionStats')"
```

### Check the disk usage of the MongoDB instance
```shell
df -h /var/lib/mongodb
```

### Check the network connectivity between the MongoDB instance and the application server
```shell
ping ${MONGODB_HOST}
```

### Check the CPU and memory usage of the application server
```shell
top
```

## Repair

### Define variables
```shell
MONGODB_HOST=${MONGODB_HOST}

MONGODB_PORT=${MONGODB_PORT}

MONGODB_USER=${MONGODB_USER}

MONGODB_PASSWORD=${MONGODB_PASSWORD}
```

### Check for issues or errors in the MongoDB database
```shell
mongo --host $MONGODB_HOST --port $MONGODB_PORT --username $MONGODB_USER --password $MONGODB_PASSWORD --eval "db.runCommand({checkDatabase: 1})"
```

### Optimize indexes
```shell
mongo --host $MONGODB_HOST --port $MONGODB_PORT --username $MONGODB_USER --password $MONGODB_PASSWORD --eval "db.adminCommand({reIndex: ${COLLECTION}})"
```

### Run database repairs
```shell
mongo --host $MONGODB_HOST --port $MONGODB_PORT --username $MONGODB_USER --password $MONGODB_PASSWORD --eval "db.adminCommand({repairDatabase: 1})"
```