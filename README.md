# Rails experiments
Simple application built to understand rails. Following "experiments" has been done
1. Users DB for CRUD operations
2. Create a resource entity (simulating any app resource like file), can be owned by only single user - To understand one-to-many mapping
3. Collaboraters - to understand many-many mapping - allow user to access any resource as either 
    1. editor
    2. viewer 

## AI Cost log

| Task | Cost |
| --- | --- |
| Fix bug in routing, by moving /user to /api/v1/user | 0.06 USD |
| Implement first draft of UserController#create | 0.12 USD |
| add migration name column to users table | 0.04 USD |
| Implement update and delete method | 0.12 USD  |
| Implement resource controller | 0.15 USD |
| Implement user authentication and update resource controller routes | 0.2 USD |
| Generate collaborator model and relevant controller logic |  |