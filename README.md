# DevOps Engineer Task

This is the solution for the home assignment. 
I have documented the solution walkthrough in `solution_walkthrough.md`, and left small comments near the changed I have made so it will be easier to understand.

The applications ran successfully in my environment: mac pro m1 - yet there was a problem that made me change the docker compose's network architecture from host to a network bridge I created, so hopefully I didnt change the logic of the assignment too much (it did make me to change a lot of places like the python scripts or the node and go application, to navigate to the url of the containers' name instead of localhost).

I have some notes for the assignment, so I hope I can help improve it for future candidates.

## Notes

This is all my humble opinion so please take this with a grain of salt.

1. The readme should be more welcoming and clear, so its easier to understand what tasks and steps the candidate should do. Without defining bounderies, I dont know if I should apply big changes that may rewriting whole parts of the logic. I have written a suggested README file in `suggested-README.md`.
2. The repo is public - thus through browsing in alexander's profile we can see all the other candidates' repos.
3. I don't see a reason to include running a node.js and go applications as part of the assignment. Maybe create a docker image with building and running steps, or create a github actions pipeline for them.

## Best Practices That Should Be Applied

1. sensitive variables like the username and password should be used as secrets.
    - fix the environment variables in the docker compose
    - the mongo keyfile

# Sources

Here are some sources I took inspiration from while working.

1. https://github.com/UpSync-Dev/docker-compose-mongo-replica-set/blob/main/docker-compose.yml
2. https://github.com/azita-abdollahi/mongodb-replicaset-docker/blob/master/docker-compose.yml