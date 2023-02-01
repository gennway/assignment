
## CI/CD PROCESS

That's my general overview of CI/CD process.

1. CI/CD tool notices change in git repository and pipeline starts.
2. CI - app goes through some tests, docker builds an image that goes to ECR with pipeline/workflowID TAG
3. CD - another script fetches current used task definitions from ecs task, creates new ECS-TD based on them with replaced tag image.
4. CD - using "aws ecs update-service" script deploys the new "version" of task definition with the new image.