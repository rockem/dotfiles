# Command: create-test

Create a single test based on my instructions. Follow these rules strictly:

1. Generate ONLY the test I describe - no additional tests
2. Do NOT implement the actual functionality being tested
3. Do NOT add helper functions, fixtures, or utilities unless I explicitly request them
4. The test should fail initially (red phase of TDD)
5. Use appropriate test framework syntax for the project (Jest/Vitest for TypeScript, pytest for Python, etc.)
6. Include clear assertions that verify the expected behavior
7. Add minimal comments only if the test logic is complex

After creating the test:

- Do NOT proceed to make it pass unless I ask

Example request format: "Create a test that verifies function X returns Y when given input Z"
