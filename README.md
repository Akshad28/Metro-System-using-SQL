# Metro Transit Database Management System

A robust SQL-based relational database management system designed to simulate, manage, and analyze a metropolitan transit system's daily operations. This project tracks metro stations across different geographic zones, passenger demographics, and ticketing metrics to drive operational insights and revenue analytics.

---

## 🚀 Project Features & Architecture

The system is built on a relational schema with strictly enforced data integrity constraints, including automatic primary key increments, unique telephone records, age thresholds, and foreign key relations linking passengers to their journeys.

### Database Schema
The database (`metro_db`) consists of three primary tables:
*   **`Metro_Stations`**: Tracks station identifiers, custom names (e.g., Sitaburdi Interchange), and transit zones.
*   **`Passengers`**: Stores rider profiles including name, contact details, gender, and age validation constraints (minimum age of 5).
*   **`Tickets`**: Logs transaction data including travel dates, ticket types (`Single`, `Return`, `Monthly`), dynamic fares, and station-to-station routing.

---

## 📂 Project Tasks Breakdown

The SQL script executes an end-to-end database workflow divided into 11 distinct operational tasks:

### 🔹 Schema Creation & Data Population
*   **Task 1 & 2:** Tables initialization with specific `CHECK` constraints for fare validation and ticket classifications. The system is populated with realistic transit data mapping out 7 major metro stations, 10 passengers, and 20 distinct travel ticket transactions.

### 🔹 Basic & Intermediate Querying
*   **Task 3 & 4:** Data retrieval pipelines filtering specific daily travel logs and high-value fare transactions.
*   **Task 5:** Advanced sorting and analytical scoping using `ORDER BY` and `LIMIT` clauses to fetch top revenue-generating trips.

### 🔹 Aggregations & Analytical Reporting
*   **Task 6:** High-level metrics tracking total network revenue, average commuter fares, minimum/maximum fare limits, and passenger distributions grouped by transit zones.

### 🔹 Relational Data Joining
*   **Task 7:** Comprehensive cross-table queries. Includes a double-join query mapping the `Tickets` table simultaneously back to the `Metro_Stations` master list twice to resolve both the **Source** and **Destination** names dynamically:
```sql
    SELECT T.*,
           S.Station_Name AS Source_Station,
           D.Station_Name AS Destination_Station
    FROM Tickets T
    JOIN Metro_Stations S ON t.Source_Station = s.Station_ID
    JOIN Metro_Stations D ON t.Destination_Station = d.Station_ID;
    ```

### 🔹 Data Modification & Auditing
*   **Task 8:** Dynamic data maintenance, including automatic fare adjustments for economic routes (adding inflation adjustments to fares under $30) and transaction logging deletions.

### 🔹 Advanced Subqueries & Business Intelligence
*   **Task 9:** Complex logic execution to identify frequent commuters (riders with more than 1 ticket purchase) and isolating peak traffic nodes by extracting the most heavily utilized source station via aggregated subquery maxing:
```sql
    SELECT s.Source_Station
    FROM (SELECT Source_Station, COUNT(*) AS Ticket_Count FROM Tickets GROUP BY Source_Station) s
    JOIN (SELECT MAX(Ticket_Count) AS MaxCount FROM (SELECT Source_Station, COUNT(*) AS Ticket_Count FROM Tickets GROUP BY Source_Station) x) m 
    ON s.Ticket_Count = m.MaxCount;
    ```

### 🔹 Database Views & Automated Logic
*   **Task 10:** Creates a virtual analytics view (`Revv`) to monitor daily revenue trends.
*   **Task 11:** Simulates a concession workflow by executing an automated 20% discount on ticket fares for senior citizens (passengers aged over 60) utilizing cross-table updates.

---

## 🛠️ How to Run This Project

1. Open your preferred SQL workbench (e.g., MySQL Workbench, phpMyAdmin, or Command Line Client).
2. Clone or download the `.sql` script from this repository.
3. Import and execute the script to instantly spin up the schema, populate test data, and see the query executions in action:
```sql
   SOURCE path/to/your/file.sql;
