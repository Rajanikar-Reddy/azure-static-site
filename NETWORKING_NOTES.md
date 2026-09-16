# Networking Notes

Real concepts learned hands-on in this repo, kept here as interview-ready reference.

## NSG (Network Security Group)
A firewall with rules. Each rule has 6 parts: **priority**, **direction** (inbound/outbound), **access** (allow/deny), **protocol** (Tcp/Udp/Any), **port**, **source**.

Rules are evaluated in priority order (lower number = checked first). First match wins — evaluation stops there. A broad deny at a low priority number can silently block a more specific allow sitting behind it at a higher number. Specificity never overrides priority order.

Two NSGs can both apply to the same VM (subnet-level + NIC-level) — both must allow traffic for it to get through.

## VNet / Subnet
A VNet is a private, isolated network. A subnet is a smaller IP range carved out of it. CIDR suffix (`/24`, `/28`) controls size: each `+1` to the suffix halves the address count, because it removes one binary bit of freedom (`2^free-bits` = address count).

Private IP ranges are fixed by RFC 1918: `10.0.0.0/8`, `172.16.0.0/12`, `192.168.0.0/16`. Millions of separate private networks can reuse the same private IP with no conflict — it only has meaning inside its own network.

Two VNets are isolated from each other by default, even in the same subscription/region. No route exists between them until you set up **peering** — this isn't a firewall rule being enforced, there's simply no path.

## Load Balancers
Distributes traffic across multiple backend servers so no single one gets overwhelmed, and traffic reroutes automatically if one fails (high availability).

- **Public Load Balancer** — has a public IP, faces the internet (e.g. web servers during a big traffic spike).
- **Internal Load Balancer** — private IP only, reachable only from inside the VNet (e.g. balancing traffic across backend database servers that should never be internet-facing).

## Private Endpoints
Gives a resource (like a storage account) a private IP inside your VNet, and lets you disable its public internet path entirely.

Key distinction: **RBAC = authorization** (checked at the door — is this identity allowed in). **Private Endpoint = network routing** (is there even a road to the door at all, for someone outside the VNet). Two separate, independent layers — stolen credentials alone don't help an attacker if there's no network path to the resource in the first place. Both would need to fail together for a breach.

## Real hands-on this repo has done
- Created NSG rules including a real priority-conflict trap (broad deny at low priority silently blocking a specific allow behind it).
- Created a VNet + subnet, attached an NSG to the subnet.
- Built a custom RBAC role from a real permission string (`Microsoft.Compute/virtualMachines/restart/action`, found via `az provider operation show | grep`), assigned it, then cleaned it up.
