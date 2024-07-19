from pymongo import MongoClient

# Connect to MongoDB
client = MongoClient("mongodb://localhost:27017/")  # Replace with your connection details
db = client["logs"]  # Replace "logs" with your database name
collection = db["nginx"]  # Replace "nginx" with your collection name

# Use aggregation framework to find top 10 IPs
pipeline = [
    {"$group": {"_id": "$remote_addr", "count": {"$sum": 1}}},
    {"$sort": {"count": -1}},
    {"$limit": 10},
]

# Execute aggregation and fetch results
top_ips = list(collection.aggregate(pipeline))

# Print results
print("Top 10 Most Frequent IPs:")
for ip in top_ips:
    print(f"\t- {ip['_id']}: {ip['count']} occurrences")

# Close connection (optional)
client.close()
