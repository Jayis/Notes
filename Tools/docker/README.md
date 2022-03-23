Here's several files that I found helpful.

- Dockerfile  
    the dockerfile builds a docker that you can connect it to.  
    You can connect it with the command
    ```bash
    ssh root@$HOST -p $EXPOSED_PORT 
    ```

    if it is not working, it is probably due to
    1. the config modification of /etc/ssh/sshd_config wasn't done correctly.
    2. ssh service still not yet started. run "/usr/sbin/sshd" manually to solve the problem.

- my_docker_runner.sh  
    a quick docker CLI runner script

