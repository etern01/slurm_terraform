## Terraform Variables

This repository utilizes the following Terraform variables:

### image_id

- **Type:** string
- **Description:** Default image ID

### instance_group_name

- **Type:** string
- **Description:** Default name

### ipv4_cidr_blocks

- **Type:** list(list(string))
- **Description:** List of IPv4 CIDR blocks

### labels

- **Type:** map(string)

### resources

- **Type:** object({ cores = number, disk = number, memory = number })
- **Description:** An object containing resource specifications for a deployment:
  - `cores`: Number of CPU cores
  - `disk`: Amount of disk space in GB
  - `memory`: Amount of memory in GB

### lb-port

- **Type:** number
- **Description:** Port for the load balancer
- **Default:** 80

### healthcheck-lb

- **Type:** object({ timeout = string, interval = string, path = string })
- **Description:** An object containing configuration for load balancer health checks:
  - `timeout`: Timeout duration for health checks
  - `interval`: Interval between health checks
  - `path`: Path to check for health status

### az

- **Type:** list(string)
- **Default:** ["ru-central1-a", "ru-central1-b", "ru-central1-c"]
- **Description:** List of availability zones

### public_ssh_key_path

- **Type:** string

### vm_count

- **Type:** number
- **Description:** Number of virtual machines

### folder_id

- **Type:** string
- **Description:** Folder ID
