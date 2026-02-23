# Bonus Exercise 5: Drizzle ORM (20 bonus points)

> This exercise is **optional** and counts as **bonus** points. It is not required for the core assignment.

## Learning Objectives

- Set up Drizzle ORM with PostgreSQL
- Define database schemas in TypeScript
- Perform CRUD operations with type safety
- Write complex queries using Drizzle's query builder
- Understand ORM vs raw SQL trade-offs

## Background

ORMs (Object-Relational Mappers) provide a type-safe way to interact with databases from application code. **Drizzle ORM** is a modern TypeScript ORM that:

- Generates SQL from TypeScript
- Provides full type safety
- Has minimal runtime overhead
- Supports complex queries and joins

## Setup Instructions

### Step 1: Navigate to the drizzle directory

```bash
cd drizzle
```

### Step 2: Install dependencies (optional)

```bash
npm install
```

### Step 3: Verify database connection

Ensure Docker containers are running:
```bash
docker compose up -d
```

### Step 4: Run the initial test (optional)

```bash
npm run test:connection
```

You should see "Database connection successful!"

---

## Project Structure

```
drizzle/
├── package.json
├── tsconfig.json
├── drizzle.config.ts
└── src/
    ├── db.ts            # Database connection
    ├── schema.ts        # Drizzle schema (provided)
    ├── queries.ts       # Your query implementations
    └── index.ts         # Test runner
```

---

## Problem 5.1: Basic CRUD Operations (4 points)

Complete the CRUD functions in `src/queries.ts`:

### 5.1a: Get all active materials

```typescript
export async function getActiveMaterials() {
  // Return all materials where deleted_at is null
  // Order by name ascending
}
```

### 5.1b: Get material by SKU

```typescript
export async function getMaterialBySku(sku: string) {
  // Return a single material matching the SKU
  // Return null if not found
}
```

### 5.1c: Create a new material

```typescript
export async function createMaterial(material: NewMaterial) {
  // Insert a new material
  // Return the inserted record
}
```

### 5.1d: Update material stock

```typescript
export async function updateMaterialStock(materialId: number, newQuantity: number) {
  // Update quantity_in_stock for the given material
  // Return the updated record
}
```

**Test your implementation:**
```bash
npm run test:crud
```

---

## Problem 5.2: Query with Filters (4 points)

Implement filtered query functions:

### 5.2a: Get materials below reorder level

```typescript
export async function getMaterialsBelowReorder() {
  // Return materials where quantity_in_stock < reorder_level
  // Only include active materials (deleted_at is null)
  // Order by (reorder_level - quantity_in_stock) descending
}
```

### 5.2b: Get parts by category

```typescript
export async function getPartsByCategory(category: string) {
  // Return active parts in the given category
  // Include part_number, name, base_price
  // Order by base_price descending
}
```

### 5.2c: Search parts by name

```typescript
export async function searchParts(searchTerm: string) {
  // Return parts where name contains the search term (case insensitive)
  // Use ILIKE for pattern matching
  // Only include active parts
}
```

**Test your implementation:**
```bash
npm run test:filters
```

---

## Problem 5.3: Joins and Relations (5 points)

Implement queries that join multiple tables:

### 5.3a: Get production orders with items

```typescript
export async function getOrderWithItems(orderNumber: string) {
  // Return order details with all line items
  // Include: order info, item quantities, part details
  // Structure as: { order: {...}, items: [{...}, ...] }
}
```

### 5.3b: Get part with bill of materials

```typescript
export async function getPartWithMaterials(partNumber: string) {
  // Return part details with all required materials
  // Include: part info, materials with quantities needed
  // Calculate total material cost
}
```

### 5.3c: Get machine production history

```typescript
export async function getMachineProductionHistory(machineId: number) {
  // Return machine info with all production runs
  // Include: machine details, runs with part info and quantities
  // Order runs by start_time descending
}
```

**Test your implementation:**
```bash
npm run test:joins
```

---

## Problem 5.4: Aggregation Queries (4 points)

Implement aggregate queries:

### 5.4a: Get inventory summary

```typescript
export async function getInventorySummary() {
  // Return summary of inventory by material type
  // Include: material_type, count, total_quantity, total_value
  // Only include active materials
}
```

### 5.4b: Get production statistics

```typescript
export async function getProductionStats() {
  // Return production statistics
  // Include: 
  //   - total_runs, completed_runs, running_runs
  //   - total_quantity_produced
  //   - average_run_quantity
}
```

### 5.4c: Get quality metrics by part

```typescript
export async function getQualityMetricsByPart() {
  // Return quality check statistics for each part
  // Include: part_number, total_checks, pass_rate, fail_rate
  // Order by pass_rate ascending (worst first)
}
```

**Test your implementation:**
```bash
npm run test:aggregation
```

---

## Problem 5.5: Transactions in Drizzle (3 points)

Implement a transactional operation:

### 5.5a: Create order with items

```typescript
export async function createOrderWithItems(
  order: NewProductionOrder,
  items: Array<{ partId: number; quantity: number }>
) {
  // Create a production order with multiple line items
  // Use a transaction to ensure atomicity
  // Return the created order with items
  
  return await db.transaction(async (tx) => {
    // Your implementation
  });
}
```

**Test your implementation:**
```bash
npm run test:transactions
```

---

## Running All Tests

```bash
npm test
```

This runs all test suites and reports results.

---

## Submission

Your completed files:
- `drizzle/src/queries.ts` - All query implementations

Make sure all tests pass before submitting:
```bash
npm test
```

## Grading Rubric

| Problem | Points | Criteria |
|---------|--------|----------|
| 5.1 | 4 | All CRUD operations work correctly with type safety |
| 5.2 | 4 | Filters work correctly, proper use of operators |
| 5.3 | 5 | Joins return correct structure, all relations included |
| 5.4 | 4 | Aggregations calculate correctly, proper grouping |
| 5.5 | 3 | Transaction creates both order and items atomically |
| **Total (bonus)** | **20** | |

## Helpful Resources

- [Drizzle ORM Documentation](https://orm.drizzle.team/docs/overview)
- [Drizzle with PostgreSQL](https://orm.drizzle.team/docs/get-started-postgresql)
- [Drizzle Query Builder](https://orm.drizzle.team/docs/rqb)
- [Drizzle Transactions](https://orm.drizzle.team/docs/transactions)
