#!/bin/bash

echo "Initializing replica set for config servers..."

mongo --host 10.0.0.3 --port 27017 <<EOF
rs.initiate(
  {
    _id: "repconfdisp",
    configsvr: true,
    members: [
      { _id : 0, host : "10.0.0.3:27017" },
      { _id : 1, host : "10.0.0.4:27017" }
    ]
  }
);
EOF

echo "Replica set initialization complete."
