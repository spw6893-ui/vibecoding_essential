#!/usr/bin/env python3
"""
List and search HeroUI Pro components from the component library.
"""
import os
import json
from pathlib import Path

# Get the script's directory and construct path to components
SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
SKILL_DIR = os.path.dirname(SCRIPT_DIR)
COMPONENTS_BASE = os.path.join(SKILL_DIR, "MyHero-main", "components")

def get_all_components():
    """Get all available components organized by category."""
    components = {}

    if not os.path.exists(COMPONENTS_BASE):
        return {"error": f"Components directory not found at {COMPONENTS_BASE}"}

    for category in os.listdir(COMPONENTS_BASE):
        category_path = os.path.join(COMPONENTS_BASE, category)
        if not os.path.isdir(category_path) or category.startswith('.'):
            continue

        components[category] = {}

        # Iterate through subcategories
        for subcategory in os.listdir(category_path):
            subcategory_path = os.path.join(category_path, subcategory)
            if not os.path.isdir(subcategory_path) or subcategory.startswith('.'):
                continue

            components[category][subcategory] = []

            # List components in subcategory
            for component in os.listdir(subcategory_path):
                component_path = os.path.join(subcategory_path, component)
                if os.path.isdir(component_path) and not component.startswith('.'):
                    # Check if it has js and ts directories
                    has_js = os.path.exists(os.path.join(component_path, 'js'))
                    has_ts = os.path.exists(os.path.join(component_path, 'ts'))

                    components[category][subcategory].append({
                        "name": component,
                        "path": component_path,
                        "has_js": has_js,
                        "has_ts": has_ts
                    })

    return components

def search_components(query):
    """Search for components by name or category."""
    query_lower = query.lower()
    results = []

    all_components = get_all_components()
    if "error" in all_components:
        return all_components

    for category, subcategories in all_components.items():
        if query_lower in category.lower():
            # Category match
            for subcategory, components in subcategories.items():
                for comp in components:
                    results.append({
                        "category": category,
                        "subcategory": subcategory,
                        "component": comp
                    })
        else:
            # Search in subcategories and component names
            for subcategory, components in subcategories.items():
                if query_lower in subcategory.lower():
                    for comp in components:
                        results.append({
                            "category": category,
                            "subcategory": subcategory,
                            "component": comp
                        })
                else:
                    for comp in components:
                        if query_lower in comp["name"].lower():
                            results.append({
                                "category": category,
                                "subcategory": subcategory,
                                "component": comp
                            })

    return results

def list_category(category):
    """List all components in a specific category."""
    all_components = get_all_components()
    if "error" in all_components:
        return all_components

    if category not in all_components:
        return {"error": f"Category '{category}' not found. Available: {', '.join(all_components.keys())}"}

    return all_components[category]

if __name__ == "__main__":
    import sys

    if len(sys.argv) < 2:
        print("Usage:")
        print("  python list_components.py list              # List all components")
        print("  python list_components.py search <query>    # Search components")
        print("  python list_components.py category <name>   # List category")
        sys.exit(1)

    command = sys.argv[1]

    if command == "list":
        components = get_all_components()
        print(json.dumps(components, indent=2))

    elif command == "search":
        if len(sys.argv) < 3:
            print("Error: Please provide a search query")
            sys.exit(1)
        query = sys.argv[2]
        results = search_components(query)
        print(json.dumps(results, indent=2))

    elif command == "category":
        if len(sys.argv) < 3:
            print("Error: Please provide a category name")
            sys.exit(1)
        category = sys.argv[2]
        results = list_category(category)
        print(json.dumps(results, indent=2))

    else:
        print(f"Unknown command: {command}")
        sys.exit(1)
