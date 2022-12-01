# Renovate reproduction case - allow Terraform Providers from custom registries

Reproducing for https://github.com/renovatebot/renovate/pull/19195 and https://github.com/renovatebot/renovate/discussions/19176.

## Actual

When running:

```
env LOG_LEVEL=debug renovate --token $GITHUB_TOKEN --dry-run jamietanna/renovate-iss-19195
```

We see that the lookup for `depName: non-existent-registry.example.com/hashicorp/hcp` fails:

```
DEBUG: http statistics (repository=jamietanna/renovate-iss-19195)
       "urls": {
         "https://api.github.com/graphql (POST,200)": 2,
         "https://api.github.com/repos/jamietanna/.github/contents/renovate-config.json (GET,404)": 1,
         "https://api.github.com/repos/jamietanna/renovate-config/contents/default.json (GET,404)": 1,
         "https://api.github.com/repos/jamietanna/renovate-config/contents/renovate.json (GET,404)": 1,
         "https://api.github.com/repos/jamietanna/renovate-iss-19195/pulls (GET,200)": 1,
         "https://registry.terraform.io/v1/providers/non-existent-registry.example.com/hashicorp/hcp (GET,404)": 1,
         "https://releases.hashicorp.com/index.json (GET,406)": 1
       },
       "hostStats": {
         "api.github.com": {"requestCount": 6, "requestAvgMs": 290, "queueAvgMs": 0},
         "registry.terraform.io": {
           "requestCount": 1,
           "requestAvgMs": 205,
           "queueAvgMs": 0
         },
         "releases.hashicorp.com": {
           "requestCount": 1,
           "requestAvgMs": 678,
           "queueAvgMs": 1
         }
       },
       "totalRequests": 8
DEBUG: dns cache (repository=jamietanna/renovate-iss-19195)
       "hosts": []
 INFO: Repository finished (repository=jamietanna/renovate-iss-19195)
       "cloned": true,
       "durationMs": 5580
DEBUG: Renovate exiting
```

But note that this is failing by looking up on the public registry, rather than the registry as noted in `depName`.

```
"https://registry.terraform.io/v1/providers/non-existent-registry.example.com/hashicorp/hcp (GET,404)": 1,
```

## Expected

The module `non-existent-registry.example.com/hashicorp/hcp` dependency lookup fails with a 404, due to:

```
"https://non-existent-registry.example.com/hashicorp/hcp (GET,404)": 1,
```
