import os
import re

ACTIVE_INVENTORY_PATH = r"C:\Users\kamil\PROJECTS\01-saving-core-os\02-inventory\tools-and-applications-inventory.md"
CANDIDATE_REGISTER_PATH = r"C:\Users\kamil\PROJECTS\01-saving-core-os\02-inventory\candidate-tools-register.md"

def parse_markdown_table(filepath):
    tools = []
    if not os.path.exists(filepath):
        return tools

    with open(filepath, "r", encoding="utf-8") as f:
        lines = f.readlines()

    table_started = False
    for line in lines:
        if "|" in line:
            # Check for header separators
            if "---|---" in line or "--- | ---" in line:
                table_started = True
                continue
            
            if not table_started:
                continue

            parts = [p.strip() for p in line.split("|") if p.strip()]
            if len(parts) >= 2:
                name = parts[0].strip("`").strip()
                status = parts[1]
                category = parts[2] if len(parts) > 2 else ""
                desc = parts[3] if len(parts) > 3 else ""
                tools.append({
                    "name": name,
                    "status": status,
                    "category": category,
                    "description": desc
                })
    return tools

def check_overlaps(skill_name, keywords):
    active_tools = parse_markdown_table(ACTIVE_INVENTORY_PATH)
    candidate_tools = parse_markdown_table(CANDIDATE_REGISTER_PATH)

    overlaps = []
    
    # Simple keyword match
    search_terms = [skill_name.lower().replace("-", " ")] + [k.lower() for k in keywords]
    
    for tool in active_tools:
        for term in search_terms:
            if term in tool["name"].lower() or term in tool["description"].lower():
                overlaps.append({
                    "name": tool["name"],
                    "source": "Active Tools Inventory",
                    "description": tool["description"],
                    "status": tool["status"]
                })
                break

    for tool in candidate_tools:
        for term in search_terms:
            if term in tool["name"].lower() or term in tool["description"].lower():
                overlaps.append({
                    "name": tool["name"],
                    "source": "Candidate Tools Register",
                    "description": tool["description"],
                    "status": tool["status"]
                })
                break

    return overlaps

if __name__ == "__main__":
    # Quick debug run
    print("Testing overlap engine...")
    matches = check_overlaps("chroma", ["rag", "embedding"])
    for m in matches:
        print(f"Found match: {m['name']} ({m['source']}) - {m['description'][:60]}")
