# Set the working application directory
# working_directory "/path/to/your/app"
working_directory "/home/ray/briefr-server"

# Unicorn PID file location
# pid "/path/to/pids/unicorn.pid"
pid "/home/ray/briefr-server/tmp/pids/unicorn.pid"

# Path to logs
# stderr_path "/path/to/log/unicorn.log"
# stdout_path "/path/to/log/unicorn.log"
stderr_path "/home/ray/briefr-server/log/unicorn.log"
stdout_path "/home/ray/briefr-server/log/unicorn.log"

# Unicorn socket
listen "/tmp/unicorn.briefr.sock"

# Number of processes
# worker_processes 4
worker_processes 8

# Time-out
timeout 30
