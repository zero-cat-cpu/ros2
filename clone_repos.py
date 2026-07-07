import yaml
import subprocess
import os
import time

with open('ros2.repos', 'r') as f:
    data = yaml.safe_load(f)

repositories = data.get('repositories', {})

failed_repos = [
    ('ament/ament_lint', 'https://github.com/ament/ament_lint.git', 'rolling'),
    ('ros-visualization/qt_gui_core', 'https://github.com/ros-visualization/qt_gui_core.git', 'rolling'),
    ('ros-visualization/rqt_action', 'https://github.com/ros-visualization/rqt_action.git', 'rolling'),
    ('ros-visualization/tango_icons_vendor', 'https://github.com/ros-visualization/tango_icons_vendor.git', 'rolling'),
    ('ros2/libyaml_vendor', 'https://github.com/ros2/libyaml_vendor.git', 'rolling'),
    ('ros2/rosidl_dds', 'https://github.com/ros2/rosidl_dds.git', 'rolling'),
    ('ros2/rosidl_typesupport', 'https://github.com/ros2/rosidl_typesupport.git', 'rolling'),
]

print(f"Retrying {len(failed_repos)} failed repositories")
print("=" * 60)

os.makedirs('src', exist_ok=True)
os.chdir('src')

still_failed = []

for i, (name, url, version) in enumerate(failed_repos, 1):
    print(f"\n[{i}/{len(failed_repos)}] Retrying {name}...")
    
    repo_dir = name.split('/')[1] if '/' in name else name
    
    if os.path.exists(repo_dir):
        print(f"  Skipping - {repo_dir} already exists")
        continue
    
    time.sleep(2)
    
    try:
        result = subprocess.run(
            ['git', 'clone', '-b', version, '--depth', '1', url, repo_dir],
            capture_output=True,
            text=True,
            timeout=300
        )
        
        if result.returncode == 0:
            print(f"  ✓ Successfully cloned")
        else:
            print(f"  ✗ Failed: {result.stderr[:200]}")
            still_failed.append((name, url, version))
            
    except subprocess.TimeoutExpired:
        print(f"  ✗ Timeout")
        still_failed.append((name, url, version))
    except Exception as e:
        print(f"  ✗ Error: {str(e)}")
        still_failed.append((name, url, version))

print("\n" + "=" * 60)
print(f"Retry completed. {len(failed_repos) - len(still_failed)}/{len(failed_repos)} successful")

if still_failed:
    print("\nStill failed repositories:")
    for name, url, version in still_failed:
        print(f"  - {name}")