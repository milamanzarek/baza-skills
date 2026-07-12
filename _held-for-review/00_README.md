# Held for review (secrets) - RESOLVED 2026-07-12

During the 2026-06-18 sweep, three skills tripped a high-confidence credential pattern and were withheld from the library pending Kamilla review. Their only copies stayed in their original source location (the CHERDAK skills_backup), not in this folder.

- comfyui-gateway (AWS-key-shaped string)
- aws-iam-best-practices (AWS-key-shaped string; likely an example in a security skill)
- k8s-manifest-generator (PRIVATE KEY header; likely an example)

Resolution (2026-07-12): Kamilla reviewed the three, did not recognize them, and chose to delete rather than retain. The CHERDAK skills_backup holding their sole copies was removed the same day. None were added to the library. Values were never extracted or printed.

This folder now holds later intake batches (from-CHERDAK-2026-07-06, from-kepano-obsidian-skills-2026-07-11) pending their own review.
