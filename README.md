# Spring Legacy Project Setup

This guide provides the **minimal steps** required to set up and run this **Spring MVC application** in a **Legacy Old Development (LOD)** environment.

This project intentionally avoids modern Spring practices. Follow the steps exactly or expect failures.

---

## 1️⃣ Prerequisites

Ensure the following are installed and configured **before doing anything else**:

* **JDK:** Version `1.8` (Java 8) Mandatory
* **Server:** Apache Tomcat `7.0` or `8.5`
* **Database:** MySQL `8.0`
* **IDE:** Eclipse (Java EE Edition)

Java 11+ is not supported
Spring Boot assumptions will break this project

---

## 2️⃣ Quick Setup Steps

### Step 1: Import Project

1. Open **Eclipse**
2. Go to **File → Import…**
3. Select **Maven → Existing Maven Projects** → **Next**
4. Browse to the project root folder
5. Click **Finish**

⏳ Wait until Maven finishes downloading all dependencies.

---

### Step 2: Fix Build Errors

If you see **red error markers** on the project:

1. Right-click **Project → Build Path → Configure Build Path**
2. **Libraries** tab:

   * Ensure **JRE System Library = JavaSE-1.8**
3. **Targeted Runtimes** tab:

   * Check your **Apache Tomcat** server
4. Click **Apply and Close**

Skipping this step guarantees build failure.

---

### Step 3: Database Configuration

1. Create your local **MySQL schema**
2. Open:

```
src/main/resources/config.xml
```

3. Update credentials:

```xml
<property name="username" value="root" />
<property name="password" value="your_password" />
```

Incorrect credentials = runtime failure.

---

## 3️⃣ Run the Application

1. Right-click the project
2. Select **Run As → Run on Server**
3. Choose your configured **Tomcat** server

Access the app at:

```
http://localhost:8080/YourProjectName/
```

If you get **404**, check `web.xml` DispatcherServlet mappings.

---

## 4️⃣ Coding Rules (SOP)

These rules are **not optional**.

### No `@Autowired`

Always load context manually:

```java
new ClassPathXmlApplicationContext("config.xml");
```

---

### ✅ Bean Retrieval Only via Context

```java
context.getBean("beanName");
```

No direct object creation.

---

### ✅ Java 8 Syntax Only

Traditional loops
Iterators

Streams
Lambdas

---

## Git Rules

Do **NOT** commit the following:

* `.settings/`
* `.metadata/`
* `bin/`

These are local-machine artifacts and will break other environments.

---

## ✅ Reminder

> This is a **Legacy Spring MVC project**.
>
> Treat it like one.
