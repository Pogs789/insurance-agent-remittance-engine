<img width="123" height="150" alt="prisma-erd" src="https://github.com/user-attachments/assets/29a97d4f-7bcb-45f6-b085-44398842e5a0" /># Insurance Agent's Remittance Management System

This is a simple tool for insurance agents which automatically calculates the monthly collection needed to be remitted to the insurance company.

## 🚧 Project Status

Some of its CORE FEATURES are already deployed and can be accessed by this URL: 

https://insurance-agent-remittance-engine-frontend.vercel.app

Documentation may not reflect the latest implementation yet.
Major updates to architecture and features are ongoing.

Last updated: March 2026

## 📋 Table of Contents
- [Problem Statement](#problem-statement)
- [Features of the Application](#features-of-the-application)
- [Technologies Used](#technologies-used)
- [Architecture](#architecture)
- [Folder Structure](#folder-structure)
    - [Flutter (Mobile App)](#flutter-mobile-app)
    - [NestJS (Backend API)](#nestjs-backend-api)
- [Getting Started](#getting-started)
- [API Documentation](#api-documentation)
- [Contributing](#contributing)

---

## 🎯 Problem Statement

Insurance Agents every single month have to manually monitor insurance planholders to ensure that they are making their payments on time.  This process is tedious, time-consuming, and prone to human error.  Additionally, insurance agents often struggle to keep track of multiple insurance plans and their respective remittance schedules.

### Solution
This application provides an automated monitoring system that:
- Tracks payment schedules automatically
- Sends timely reminders to planholders
- Provides real-time dashboard for agents
- Reduces manual tracking errors
- Streamlines the entire remittance process

---

## ✨ Features of the Application

### For Insurance Agents
- **User Authentication** - Secure Sign Up, Login, and Logout
- **Automated Calculation of Insurance Remittance** - Automated tracking of payment schedules
- **User Profile Management** - Manage agent profile and preferences

### For Admin/Insurance Providers
- **Admin Dashboard** - Comprehensive overview of all agents and policies
- **Agent Performance Tracking** - Monitor agent activities and success rates
- **Reports & Analytics** - Generate insights on payments and policy performance

---

## 🛠️ Technologies Used

### Frontend (Mobile Application)
- **Flutter** - Cross-platform framework (iOS and Android)
- **Dart** - Programming language
- **Provider** - State management solution
- **Dio** - HTTP client for API requests
- **Secure Storage** - Secured Data persistence

### Backend (API Server)
- **NestJS** - Progressive Node.js framework
- **TypeScript** - Strongly-typed programming language
- **PostgreSQL** - Relational database
- **PrismaORM** - Object-Relational Mapping
- **JWT** - JSON Web Tokens for authentication
- **Passport** - Authentication middleware

### DevOps & Tools
- **Git** - Version control
- **Docker** - Containerization (optional)
- **Postman** - API testing
- **AWS** - Cloud Platform

---

## 🏗️ Architecture

This application follows **Clean Architecture** principles, ensuring:
- ✅ **Separation of Concerns** - Each layer has a single responsibility
- ✅ **Testability** - Easy to write unit and integration tests
- ✅ **Maintainability** - Changes in one layer don't affect others
- ✅ **Scalability** - Easy to add new features
- ✅ **Independence** - Business logic is independent of frameworks and UI

### Architecture Layers

```
┌─────────────────────────────────────┐
│     Presentation Layer (UI)         │  ← User Interface (Flutter Widgets)
├─────────────────────────────────────┤
│     Providers (State Management)    │  ← State & UI Logic
├─────────────────────────────────────┤
│     Domain Layer (Business Logic)   │  ← Use Cases & Entities
├─────────────────────────────────────┤
│     Data Layer (Data Management)    │  ← Repositories & Models
├─────────────────────────────────────┤
│     Core Layer (Utilities)          │  ← API Client, Constants, Utils
└─────────────────────────────────────┘
```

### Data Flow

```
User Action → Provider → Use Case → Repository → Data Source → API → Backend
                                                                        ↓
User sees result ← Provider ← Entity ← Repository ← Model ← Response ←
```

### Database Design

![Uploading prisma-erd<?xml version="1.0" standalone="no"?>
<svg xmlns:xlink="http://www.w3.org/1999/xlink" id="mermaid-svg" width="undefined" xmlns="http://www.w3.org/2000/svg" height="undefined" style="max-width: 938.3124389648438px;" viewBox="0 0 938.3124389648438 1140"><style>#mermaid-svg{font-family:"trebuchet ms",verdana,arial,sans-serif;font-size:16px;fill:#333;}#mermaid-svg .error-icon{fill:#552222;}#mermaid-svg .error-text{fill:#552222;stroke:#552222;}#mermaid-svg .edge-thickness-normal{stroke-width:2px;}#mermaid-svg .edge-thickness-thick{stroke-width:3.5px;}#mermaid-svg .edge-pattern-solid{stroke-dasharray:0;}#mermaid-svg .edge-pattern-dashed{stroke-dasharray:3;}#mermaid-svg .edge-pattern-dotted{stroke-dasharray:2;}#mermaid-svg .marker{fill:#333333;}#mermaid-svg .marker.cross{stroke:#333333;}#mermaid-svg svg{font-family:"trebuchet ms",verdana,arial,sans-serif;font-size:16px;}#mermaid-svg .entityBox{fill:#ECECFF;stroke:#9370DB;}#mermaid-svg .attributeBoxOdd{fill:#ffffff;stroke:#9370DB;}#mermaid-svg .attributeBoxEven{fill:#f2f2f2;stroke:#9370DB;}#mermaid-svg .relationshipLabelBox{fill:hsl(80,100%,96.2745098039%);opacity:0.7;background-color:hsl(80,100%,96.2745098039%);}#mermaid-svg .relationshipLabelBox rect{opacity:0.5;}#mermaid-svg .relationshipLine{stroke:#333333;}#mermaid-svg:root{--mermaid-font-family:"trebuchet ms",verdana,arial,sans-serif;}#mermaid-svg er{fill:apa;}</style><g/><defs><marker id="ONLY_ONE_START" refX="0" refY="9" markerWidth="18" markerHeight="18" orient="auto"><path stroke="gray" fill="none" d="M9,0 L9,18 M15,0 L15,18"/></marker></defs><defs><marker id="ONLY_ONE_END" refX="18" refY="9" markerWidth="18" markerHeight="18" orient="auto"><path stroke="gray" fill="none" d="M3,0 L3,18 M9,0 L9,18"/></marker></defs><defs><marker id="ZERO_OR_ONE_START" refX="0" refY="9" markerWidth="30" markerHeight="18" orient="auto"><circle stroke="gray" fill="white" cx="21" cy="9" r="6"/><path stroke="gray" fill="none" d="M9,0 L9,18"/></marker></defs><defs><marker id="ZERO_OR_ONE_END" refX="30" refY="9" markerWidth="30" markerHeight="18" orient="auto"><circle stroke="gray" fill="white" cx="9" cy="9" r="6"/><path stroke="gray" fill="none" d="M21,0 L21,18"/></marker></defs><defs><marker id="ONE_OR_MORE_START" refX="18" refY="18" markerWidth="45" markerHeight="36" orient="auto"><path stroke="gray" fill="none" d="M0,18 Q 18,0 36,18 Q 18,36 0,18 M42,9 L42,27"/></marker></defs><defs><marker id="ONE_OR_MORE_END" refX="27" refY="18" markerWidth="45" markerHeight="36" orient="auto"><path stroke="gray" fill="none" d="M3,9 L3,27 M9,18 Q27,0 45,18 Q27,36 9,18"/></marker></defs><defs><marker id="ZERO_OR_MORE_START" refX="18" refY="18" markerWidth="57" markerHeight="36" orient="auto"><circle stroke="gray" fill="white" cx="48" cy="18" r="6"/><path stroke="gray" fill="none" d="M0,18 Q18,0 36,18 Q18,36 0,18"/></marker></defs><defs><marker id="ZERO_OR_MORE_END" refX="39" refY="18" markerWidth="57" markerHeight="36" orient="auto"><circle stroke="gray" fill="white" cx="9" cy="18" r="6"/><path stroke="gray" fill="none" d="M21,18 Q39,0 57,18 Q39,36 21,18"/></marker></defs><path class="er relationshipLine" d="M106.78125,655L106.78125,672.5C106.78125,690,106.78125,725,129.8951733907064,762.8701356198391C153.00909678141275,800.7402712396783,199.23694356282553,841.4805424793567,222.3508669535319,861.8506780991958L245.46479034423828,882.2208137190349" stroke="gray" fill="none" marker-end="url(#ONLY_ONE_END)" marker-start="url(#ZERO_OR_ONE_START)"/><path class="er relationshipLine" d="M339.39405059814453,699L339.39405059814453,709.1666666666666C339.39405059814453,719.3333333333334,339.39405059814453,739.6666666666666,339.39405059814453,758.1666666666666C339.39405059814453,776.6666666666666,339.39405059814453,793.3333333333334,339.39405059814453,801.6666666666666L339.39405059814453,810" stroke="gray" fill="none" marker-end="url(#ONLY_ONE_END)" marker-start="url(#ZERO_OR_MORE_START)"/><path class="er relationshipLine" d="M106.78125,399L106.78125,412.8333333333333C106.78125,426.6666666666667,106.78125,454.3333333333333,106.78125,485.6666666666667C106.78125,517,106.78125,552,106.78125,569.5L106.78125,587" stroke="gray" fill="none" marker-end="url(#ONLY_ONE_END)" marker-start="url(#ZERO_OR_MORE_START)"/><path class="er relationshipLine" d="M252.26879119873047,130.63194600095653L228.02086766560873,142.8599550007971C203.77294413248697,155.0879640006377,155.2770970662435,179.54398200031883,131.02917353312174,205.60532433349275C106.78125,231.66666666666666,106.78125,259.3333333333333,106.78125,273.1666666666667L106.78125,287" stroke="gray" fill="none" marker-end="url(#ONLY_ONE_END)" marker-start="url(#ZERO_OR_MORE_START)"/><path class="er relationshipLine" d="M425.31153106689453,130.63194600095653L449.5594546000163,142.8599550007971C473.807378133138,155.0879640006377,522.3032251993815,179.54398200031883,546.5511487325033,200.10532433349275C570.799072265625,220.66666666666666,570.799072265625,237.33333333333334,570.799072265625,245.66666666666666L570.799072265625,254" stroke="gray" fill="none" marker-end="url(#ONLY_ONE_END)" marker-start="url(#ZERO_OR_MORE_START)"/><path class="er relationshipLine" d="M570.799072265625,432L570.799072265625,440.3333333333333C570.799072265625,448.6666666666667,570.799072265625,465.3333333333333,570.799072265625,482C570.799072265625,498.6666666666667,570.799072265625,515.3333333333334,570.799072265625,523.6666666666666L570.799072265625,532" stroke="gray" fill="none" marker-end="url(#ONLY_ONE_END)" marker-start="url(#ZERO_OR_MORE_START)"/><path class="er relationshipLine" d="M829.3556137084961,677L829.3556137084961,690.8333333333334C829.3556137084961,704.6666666666666,829.3556137084961,732.3333333333334,763.3502298990885,773.7833302984646C697.344846089681,815.233327263596,565.3340784708658,870.4666545271921,499.3286946614583,898.0833181589901L433.3233108520508,925.699981790788" stroke="gray" fill="none" marker-end="url(#ZERO_OR_ONE_END)" marker-start="url(#ZERO_OR_MORE_START)"/><g id="User" transform="translate(245.46479034423828,810 )"><rect class="er entityBox" fill="honeydew" fill-opacity="100%" stroke="gray" x="0" y="0" width="187.8585205078125" height="310"/><text class="er entityLabel" id="entity-User" x="0" y="0" dominant-baseline="middle" text-anchor="middle" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 12px" transform="translate(93.92926025390625,12)">User</text><rect class="er attributeBoxOdd" fill="honeydew" fill-opacity="100%" stroke="gray" x="0" y="24" width="54.095550537109375" height="22"/><text class="er entityLabel" id="entity-User-attr-1-type" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(5,35)">String</text><rect class="er attributeBoxOdd" fill="honeydew" fill-opacity="100%" stroke="gray" x="054.095550537109375" y="24" width="133.76296997070312" height="22"/><text class="er entityLabel" id="entity-User-attr-1-name" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(59.095550537109375,35)">id</text><rect class="er attributeBoxEven" fill="honeydew" fill-opacity="100%" stroke="gray" x="0" y="46" width="54.095550537109375" height="22"/><text class="er entityLabel" id="entity-User-attr-2-type" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(5,57)">String</text><rect class="er attributeBoxEven" fill="honeydew" fill-opacity="100%" stroke="gray" x="054.095550537109375" y="46" width="133.76296997070312" height="22"/><text class="er entityLabel" id="entity-User-attr-2-name" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(59.095550537109375,57)">firstName</text><rect class="er attributeBoxOdd" fill="honeydew" fill-opacity="100%" stroke="gray" x="0" y="68" width="54.095550537109375" height="22"/><text class="er entityLabel" id="entity-User-attr-3-type" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(5,79)">String</text><rect class="er attributeBoxOdd" fill="honeydew" fill-opacity="100%" stroke="gray" x="054.095550537109375" y="68" width="133.76296997070312" height="22"/><text class="er entityLabel" id="entity-User-attr-3-name" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(59.095550537109375,79)">middleName</text><rect class="er attributeBoxEven" fill="honeydew" fill-opacity="100%" stroke="gray" x="0" y="90" width="54.095550537109375" height="22"/><text class="er entityLabel" id="entity-User-attr-4-type" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(5,101)">String</text><rect class="er attributeBoxEven" fill="honeydew" fill-opacity="100%" stroke="gray" x="054.095550537109375" y="90" width="133.76296997070312" height="22"/><text class="er entityLabel" id="entity-User-attr-4-name" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(59.095550537109375,101)">lastName</text><rect class="er attributeBoxOdd" fill="honeydew" fill-opacity="100%" stroke="gray" x="0" y="112" width="54.095550537109375" height="22"/><text class="er entityLabel" id="entity-User-attr-5-type" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(5,123)">DateTime</text><rect class="er attributeBoxOdd" fill="honeydew" fill-opacity="100%" stroke="gray" x="054.095550537109375" y="112" width="133.76296997070312" height="22"/><text class="er entityLabel" id="entity-User-attr-5-name" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(59.095550537109375,123)">birthDate</text><rect class="er attributeBoxEven" fill="honeydew" fill-opacity="100%" stroke="gray" x="0" y="134" width="54.095550537109375" height="22"/><text class="er entityLabel" id="entity-User-attr-6-type" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(5,145)">Role</text><rect class="er attributeBoxEven" fill="honeydew" fill-opacity="100%" stroke="gray" x="054.095550537109375" y="134" width="133.76296997070312" height="22"/><text class="er entityLabel" id="entity-User-attr-6-name" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(59.095550537109375,145)">role</text><rect class="er attributeBoxOdd" fill="honeydew" fill-opacity="100%" stroke="gray" x="0" y="156" width="54.095550537109375" height="22"/><text class="er entityLabel" id="entity-User-attr-7-type" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(5,167)">String</text><rect class="er attributeBoxOdd" fill="honeydew" fill-opacity="100%" stroke="gray" x="054.095550537109375" y="156" width="133.76296997070312" height="22"/><text class="er entityLabel" id="entity-User-attr-7-name" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(59.095550537109375,167)">email</text><rect class="er attributeBoxEven" fill="honeydew" fill-opacity="100%" stroke="gray" x="0" y="178" width="54.095550537109375" height="22"/><text class="er entityLabel" id="entity-User-attr-8-type" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(5,189)">String</text><rect class="er attributeBoxEven" fill="honeydew" fill-opacity="100%" stroke="gray" x="054.095550537109375" y="178" width="133.76296997070312" height="22"/><text class="er entityLabel" id="entity-User-attr-8-name" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(59.095550537109375,189)">passwordHash</text><rect class="er attributeBoxOdd" fill="honeydew" fill-opacity="100%" stroke="gray" x="0" y="200" width="54.095550537109375" height="22"/><text class="er entityLabel" id="entity-User-attr-9-type" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(5,211)">DateTime</text><rect class="er attributeBoxOdd" fill="honeydew" fill-opacity="100%" stroke="gray" x="054.095550537109375" y="200" width="133.76296997070312" height="22"/><text class="er entityLabel" id="entity-User-attr-9-name" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(59.095550537109375,211)">emailConfirmedAt</text><rect class="er attributeBoxEven" fill="honeydew" fill-opacity="100%" stroke="gray" x="0" y="222" width="54.095550537109375" height="22"/><text class="er entityLabel" id="entity-User-attr-10-type" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(5,233)">String</text><rect class="er attributeBoxEven" fill="honeydew" fill-opacity="100%" stroke="gray" x="054.095550537109375" y="222" width="133.76296997070312" height="22"/><text class="er entityLabel" id="entity-User-attr-10-name" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(59.095550537109375,233)">verificationToken</text><rect class="er attributeBoxOdd" fill="honeydew" fill-opacity="100%" stroke="gray" x="0" y="244" width="54.095550537109375" height="22"/><text class="er entityLabel" id="entity-User-attr-11-type" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(5,255)">DateTime</text><rect class="er attributeBoxOdd" fill="honeydew" fill-opacity="100%" stroke="gray" x="054.095550537109375" y="244" width="133.76296997070312" height="22"/><text class="er entityLabel" id="entity-User-attr-11-name" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(59.095550537109375,255)">verificationTokenExpiresAt</text><rect class="er attributeBoxEven" fill="honeydew" fill-opacity="100%" stroke="gray" x="0" y="266" width="54.095550537109375" height="22"/><text class="er entityLabel" id="entity-User-attr-12-type" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(5,277)">DateTime</text><rect class="er attributeBoxEven" fill="honeydew" fill-opacity="100%" stroke="gray" x="054.095550537109375" y="266" width="133.76296997070312" height="22"/><text class="er entityLabel" id="entity-User-attr-12-name" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(59.095550537109375,277)">createdAt</text><rect class="er attributeBoxOdd" fill="honeydew" fill-opacity="100%" stroke="gray" x="0" y="288" width="54.095550537109375" height="22"/><text class="er entityLabel" id="entity-User-attr-13-type" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(5,299)">DateTime</text><rect class="er attributeBoxOdd" fill="honeydew" fill-opacity="100%" stroke="gray" x="054.095550537109375" y="288" width="133.76296997070312" height="22"/><text class="er entityLabel" id="entity-User-attr-13-name" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(59.095550537109375,299)">updatedAt</text></g><g id="InsuranceAgent" transform="translate(35.9737548828125,587 )"><rect class="er entityBox" fill="honeydew" fill-opacity="100%" stroke="gray" x="0" y="0" width="141.614990234375" height="68"/><text class="er entityLabel" id="entity-InsuranceAgent" x="0" y="0" dominant-baseline="middle" text-anchor="middle" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 12px" transform="translate(70.8074951171875,12)">InsuranceAgent</text><rect class="er attributeBoxOdd" fill="honeydew" fill-opacity="100%" stroke="gray" x="0" y="24" width="37.39605712890625" height="22"/><text class="er entityLabel" id="entity-InsuranceAgent-attr-1-type" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(5,35)">String</text><rect class="er attributeBoxOdd" fill="honeydew" fill-opacity="100%" stroke="gray" x="037.39605712890625" y="24" width="104.21893310546875" height="22"/><text class="er entityLabel" id="entity-InsuranceAgent-attr-1-name" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(42.39605712890625,35)">id</text><rect class="er attributeBoxEven" fill="honeydew" fill-opacity="100%" stroke="gray" x="0" y="46" width="37.39605712890625" height="22"/><text class="er entityLabel" id="entity-InsuranceAgent-attr-2-type" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(5,57)">String</text><rect class="er attributeBoxEven" fill="honeydew" fill-opacity="100%" stroke="gray" x="037.39605712890625" y="46" width="104.21893310546875" height="22"/><text class="er entityLabel" id="entity-InsuranceAgent-attr-2-name" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(42.39605712890625,57)">insuranceCompanyId</text></g><g id="RefreshToken" transform="translate(277.5887451171875,543 )"><rect class="er entityBox" fill="honeydew" fill-opacity="100%" stroke="gray" x="0" y="0" width="123.61061096191406" height="156"/><text class="er entityLabel" id="entity-RefreshToken" x="0" y="0" dominant-baseline="middle" text-anchor="middle" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 12px" transform="translate(61.80530548095703,12)">RefreshToken</text><rect class="er attributeBoxOdd" fill="honeydew" fill-opacity="100%" stroke="gray" x="0" y="24" width="54.095550537109375" height="22"/><text class="er entityLabel" id="entity-RefreshToken-attr-1-type" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(5,35)">String</text><rect class="er attributeBoxOdd" fill="honeydew" fill-opacity="100%" stroke="gray" x="054.095550537109375" y="24" width="69.51506042480469" height="22"/><text class="er entityLabel" id="entity-RefreshToken-attr-1-name" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(59.095550537109375,35)">id</text><rect class="er attributeBoxEven" fill="honeydew" fill-opacity="100%" stroke="gray" x="0" y="46" width="54.095550537109375" height="22"/><text class="er entityLabel" id="entity-RefreshToken-attr-2-type" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(5,57)">String</text><rect class="er attributeBoxEven" fill="honeydew" fill-opacity="100%" stroke="gray" x="054.095550537109375" y="46" width="69.51506042480469" height="22"/><text class="er entityLabel" id="entity-RefreshToken-attr-2-name" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(59.095550537109375,57)">tokenHash</text><rect class="er attributeBoxOdd" fill="honeydew" fill-opacity="100%" stroke="gray" x="0" y="68" width="54.095550537109375" height="22"/><text class="er entityLabel" id="entity-RefreshToken-attr-3-type" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(5,79)">DateTime</text><rect class="er attributeBoxOdd" fill="honeydew" fill-opacity="100%" stroke="gray" x="054.095550537109375" y="68" width="69.51506042480469" height="22"/><text class="er entityLabel" id="entity-RefreshToken-attr-3-name" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(59.095550537109375,79)">expiresAt</text><rect class="er attributeBoxEven" fill="honeydew" fill-opacity="100%" stroke="gray" x="0" y="90" width="54.095550537109375" height="22"/><text class="er entityLabel" id="entity-RefreshToken-attr-4-type" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(5,101)">DateTime</text><rect class="er attributeBoxEven" fill="honeydew" fill-opacity="100%" stroke="gray" x="054.095550537109375" y="90" width="69.51506042480469" height="22"/><text class="er entityLabel" id="entity-RefreshToken-attr-4-name" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(59.095550537109375,101)">revokedAt</text><rect class="er attributeBoxOdd" fill="honeydew" fill-opacity="100%" stroke="gray" x="0" y="112" width="54.095550537109375" height="22"/><text class="er entityLabel" id="entity-RefreshToken-attr-5-type" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(5,123)">String</text><rect class="er attributeBoxOdd" fill="honeydew" fill-opacity="100%" stroke="gray" x="054.095550537109375" y="112" width="69.51506042480469" height="22"/><text class="er entityLabel" id="entity-RefreshToken-attr-5-name" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(59.095550537109375,123)">replacedById</text><rect class="er attributeBoxEven" fill="honeydew" fill-opacity="100%" stroke="gray" x="0" y="134" width="54.095550537109375" height="22"/><text class="er entityLabel" id="entity-RefreshToken-attr-6-type" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(5,145)">DateTime</text><rect class="er attributeBoxEven" fill="honeydew" fill-opacity="100%" stroke="gray" x="054.095550537109375" y="134" width="69.51506042480469" height="22"/><text class="er entityLabel" id="entity-RefreshToken-attr-6-name" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(59.095550537109375,145)">createdAt</text></g><g id="MonthlyRemittanceHistory" transform="translate(20,287 )"><rect class="er entityBox" fill="honeydew" fill-opacity="100%" stroke="gray" x="0" y="0" width="173.5625" height="112"/><text class="er entityLabel" id="entity-MonthlyRemittanceHistory" x="0" y="0" dominant-baseline="middle" text-anchor="middle" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 12px" transform="translate(86.78125,12)">MonthlyRemittanceHistory</text><rect class="er attributeBoxOdd" fill="honeydew" fill-opacity="100%" stroke="gray" x="0" y="24" width="70.52751922607422" height="22"/><text class="er entityLabel" id="entity-MonthlyRemittanceHistory-attr-1-type" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(5,35)">String</text><rect class="er attributeBoxOdd" fill="honeydew" fill-opacity="100%" stroke="gray" x="070.52751922607422" y="24" width="103.03498077392578" height="22"/><text class="er entityLabel" id="entity-MonthlyRemittanceHistory-attr-1-name" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(75.52751922607422,35)">id</text><rect class="er attributeBoxEven" fill="honeydew" fill-opacity="100%" stroke="gray" x="0" y="46" width="70.52751922607422" height="22"/><text class="er entityLabel" id="entity-MonthlyRemittanceHistory-attr-2-type" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(5,57)">Decimal</text><rect class="er attributeBoxEven" fill="honeydew" fill-opacity="100%" stroke="gray" x="070.52751922607422" y="46" width="103.03498077392578" height="22"/><text class="er entityLabel" id="entity-MonthlyRemittanceHistory-attr-2-name" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(75.52751922607422,57)">amountRemitted</text><rect class="er attributeBoxOdd" fill="honeydew" fill-opacity="100%" stroke="gray" x="0" y="68" width="70.52751922607422" height="22"/><text class="er entityLabel" id="entity-MonthlyRemittanceHistory-attr-3-type" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(5,79)">DateTime</text><rect class="er attributeBoxOdd" fill="honeydew" fill-opacity="100%" stroke="gray" x="070.52751922607422" y="68" width="103.03498077392578" height="22"/><text class="er entityLabel" id="entity-MonthlyRemittanceHistory-attr-3-name" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(75.52751922607422,79)">createdAt</text><rect class="er attributeBoxEven" fill="honeydew" fill-opacity="100%" stroke="gray" x="0" y="90" width="70.52751922607422" height="22"/><text class="er entityLabel" id="entity-MonthlyRemittanceHistory-attr-4-type" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(5,101)">DateTime</text><rect class="er attributeBoxEven" fill="honeydew" fill-opacity="100%" stroke="gray" x="070.52751922607422" y="90" width="103.03498077392578" height="22"/><text class="er entityLabel" id="entity-MonthlyRemittanceHistory-attr-4-name" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(75.52751922607422,101)">updatedAt</text></g><g id="PlanholderData" transform="translate(252.26879119873047,20 )"><rect class="er entityBox" fill="honeydew" fill-opacity="100%" stroke="gray" x="0" y="0" width="173.04273986816406" height="134"/><text class="er entityLabel" id="entity-PlanholderData" x="0" y="0" dominant-baseline="middle" text-anchor="middle" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 12px" transform="translate(86.52136993408203,12)">PlanholderData</text><rect class="er attributeBoxOdd" fill="honeydew" fill-opacity="100%" stroke="gray" x="0" y="24" width="87.81930541992188" height="22"/><text class="er entityLabel" id="entity-PlanholderData-attr-1-type" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(5,35)">String</text><rect class="er attributeBoxOdd" fill="honeydew" fill-opacity="100%" stroke="gray" x="087.81930541992188" y="24" width="85.22343444824219" height="22"/><text class="er entityLabel" id="entity-PlanholderData-attr-1-name" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(92.81930541992188,35)">id</text><rect class="er attributeBoxEven" fill="honeydew" fill-opacity="100%" stroke="gray" x="0" y="46" width="87.81930541992188" height="22"/><text class="er entityLabel" id="entity-PlanholderData-attr-2-type" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(5,57)">String</text><rect class="er attributeBoxEven" fill="honeydew" fill-opacity="100%" stroke="gray" x="087.81930541992188" y="46" width="85.22343444824219" height="22"/><text class="er entityLabel" id="entity-PlanholderData-attr-2-name" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(92.81930541992188,57)">planholderName</text><rect class="er attributeBoxOdd" fill="honeydew" fill-opacity="100%" stroke="gray" x="0" y="68" width="87.81930541992188" height="22"/><text class="er entityLabel" id="entity-PlanholderData-attr-3-type" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(5,79)">PlanholderStatus</text><rect class="er attributeBoxOdd" fill="honeydew" fill-opacity="100%" stroke="gray" x="087.81930541992188" y="68" width="85.22343444824219" height="22"/><text class="er entityLabel" id="entity-PlanholderData-attr-3-name" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(92.81930541992188,79)">currentStatus</text><rect class="er attributeBoxEven" fill="honeydew" fill-opacity="100%" stroke="gray" x="0" y="90" width="87.81930541992188" height="22"/><text class="er entityLabel" id="entity-PlanholderData-attr-4-type" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(5,101)">DateTime</text><rect class="er attributeBoxEven" fill="honeydew" fill-opacity="100%" stroke="gray" x="087.81930541992188" y="90" width="85.22343444824219" height="22"/><text class="er entityLabel" id="entity-PlanholderData-attr-4-name" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(92.81930541992188,101)">createdAt</text><rect class="er attributeBoxOdd" fill="honeydew" fill-opacity="100%" stroke="gray" x="0" y="112" width="87.81930541992188" height="22"/><text class="er entityLabel" id="entity-PlanholderData-attr-5-type" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(5,123)">DateTime</text><rect class="er attributeBoxOdd" fill="honeydew" fill-opacity="100%" stroke="gray" x="087.81930541992188" y="112" width="85.22343444824219" height="22"/><text class="er entityLabel" id="entity-PlanholderData-attr-5-name" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(92.81930541992188,123)">updatedAt</text></g><g id="InsuranceProduct" transform="translate(486.23804473876953,254 )"><rect class="er entityBox" fill="honeydew" fill-opacity="100%" stroke="gray" x="0" y="0" width="169.12205505371094" height="178"/><text class="er entityLabel" id="entity-InsuranceProduct" x="0" y="0" dominant-baseline="middle" text-anchor="middle" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 12px" transform="translate(84.56102752685547,12)">InsuranceProduct</text><rect class="er attributeBoxOdd" fill="honeydew" fill-opacity="100%" stroke="gray" x="0" y="24" width="54.095550537109375" height="22"/><text class="er entityLabel" id="entity-InsuranceProduct-attr-1-type" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(5,35)">String</text><rect class="er attributeBoxOdd" fill="honeydew" fill-opacity="100%" stroke="gray" x="054.095550537109375" y="24" width="115.02650451660156" height="22"/><text class="er entityLabel" id="entity-InsuranceProduct-attr-1-name" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(59.095550537109375,35)">id</text><rect class="er attributeBoxEven" fill="honeydew" fill-opacity="100%" stroke="gray" x="0" y="46" width="54.095550537109375" height="22"/><text class="er entityLabel" id="entity-InsuranceProduct-attr-2-type" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(5,57)">String</text><rect class="er attributeBoxEven" fill="honeydew" fill-opacity="100%" stroke="gray" x="054.095550537109375" y="46" width="115.02650451660156" height="22"/><text class="er entityLabel" id="entity-InsuranceProduct-attr-2-name" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(59.095550537109375,57)">insuranceProductName</text><rect class="er attributeBoxOdd" fill="honeydew" fill-opacity="100%" stroke="gray" x="0" y="68" width="54.095550537109375" height="22"/><text class="er entityLabel" id="entity-InsuranceProduct-attr-3-type" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(5,79)">String</text><rect class="er attributeBoxOdd" fill="honeydew" fill-opacity="100%" stroke="gray" x="054.095550537109375" y="68" width="115.02650451660156" height="22"/><text class="er entityLabel" id="entity-InsuranceProduct-attr-3-name" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(59.095550537109375,79)">productContents</text><rect class="er attributeBoxEven" fill="honeydew" fill-opacity="100%" stroke="gray" x="0" y="90" width="54.095550537109375" height="22"/><text class="er entityLabel" id="entity-InsuranceProduct-attr-4-type" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(5,101)">Decimal</text><rect class="er attributeBoxEven" fill="honeydew" fill-opacity="100%" stroke="gray" x="054.095550537109375" y="90" width="115.02650451660156" height="22"/><text class="er entityLabel" id="entity-InsuranceProduct-attr-4-name" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(59.095550537109375,101)">productAmount</text><rect class="er attributeBoxOdd" fill="honeydew" fill-opacity="100%" stroke="gray" x="0" y="112" width="54.095550537109375" height="22"/><text class="er entityLabel" id="entity-InsuranceProduct-attr-5-type" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(5,123)">String</text><rect class="er attributeBoxOdd" fill="honeydew" fill-opacity="100%" stroke="gray" x="054.095550537109375" y="112" width="115.02650451660156" height="22"/><text class="er entityLabel" id="entity-InsuranceProduct-attr-5-name" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(59.095550537109375,123)">paymentTerms</text><rect class="er attributeBoxEven" fill="honeydew" fill-opacity="100%" stroke="gray" x="0" y="134" width="54.095550537109375" height="22"/><text class="er entityLabel" id="entity-InsuranceProduct-attr-6-type" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(5,145)">DateTime</text><rect class="er attributeBoxEven" fill="honeydew" fill-opacity="100%" stroke="gray" x="054.095550537109375" y="134" width="115.02650451660156" height="22"/><text class="er entityLabel" id="entity-InsuranceProduct-attr-6-name" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(59.095550537109375,145)">createdAt</text><rect class="er attributeBoxOdd" fill="honeydew" fill-opacity="100%" stroke="gray" x="0" y="156" width="54.095550537109375" height="22"/><text class="er entityLabel" id="entity-InsuranceProduct-attr-7-type" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(5,167)">DateTime</text><rect class="er attributeBoxOdd" fill="honeydew" fill-opacity="100%" stroke="gray" x="054.095550537109375" y="156" width="115.02650451660156" height="22"/><text class="er entityLabel" id="entity-InsuranceProduct-attr-7-name" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(59.095550537109375,167)">updatedAt</text></g><g id="InsuranceCompany" transform="translate(501.19935607910156,532 )"><rect class="er entityBox" fill="honeydew" fill-opacity="100%" stroke="gray" x="0" y="0" width="139.19943237304688" height="178"/><text class="er entityLabel" id="entity-InsuranceCompany" x="0" y="0" dominant-baseline="middle" text-anchor="middle" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 12px" transform="translate(69.59971618652344,12)">InsuranceCompany</text><rect class="er attributeBoxOdd" fill="honeydew" fill-opacity="100%" stroke="gray" x="0" y="24" width="54.095550537109375" height="22"/><text class="er entityLabel" id="entity-InsuranceCompany-attr-1-type" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(5,35)">String</text><rect class="er attributeBoxOdd" fill="honeydew" fill-opacity="100%" stroke="gray" x="054.095550537109375" y="24" width="85.1038818359375" height="22"/><text class="er entityLabel" id="entity-InsuranceCompany-attr-1-name" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(59.095550537109375,35)">id</text><rect class="er attributeBoxEven" fill="honeydew" fill-opacity="100%" stroke="gray" x="0" y="46" width="54.095550537109375" height="22"/><text class="er entityLabel" id="entity-InsuranceCompany-attr-2-type" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(5,57)">String</text><rect class="er attributeBoxEven" fill="honeydew" fill-opacity="100%" stroke="gray" x="054.095550537109375" y="46" width="85.1038818359375" height="22"/><text class="er entityLabel" id="entity-InsuranceCompany-attr-2-name" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(59.095550537109375,57)">companyName</text><rect class="er attributeBoxOdd" fill="honeydew" fill-opacity="100%" stroke="gray" x="0" y="68" width="54.095550537109375" height="22"/><text class="er entityLabel" id="entity-InsuranceCompany-attr-3-type" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(5,79)">String</text><rect class="er attributeBoxOdd" fill="honeydew" fill-opacity="100%" stroke="gray" x="054.095550537109375" y="68" width="85.1038818359375" height="22"/><text class="er entityLabel" id="entity-InsuranceCompany-attr-3-name" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(59.095550537109375,79)">branchAddress</text><rect class="er attributeBoxEven" fill="honeydew" fill-opacity="100%" stroke="gray" x="0" y="90" width="54.095550537109375" height="22"/><text class="er entityLabel" id="entity-InsuranceCompany-attr-4-type" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(5,101)">String</text><rect class="er attributeBoxEven" fill="honeydew" fill-opacity="100%" stroke="gray" x="054.095550537109375" y="90" width="85.1038818359375" height="22"/><text class="er entityLabel" id="entity-InsuranceCompany-attr-4-name" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(59.095550537109375,101)">productsOffered</text><rect class="er attributeBoxOdd" fill="honeydew" fill-opacity="100%" stroke="gray" x="0" y="112" width="54.095550537109375" height="22"/><text class="er entityLabel" id="entity-InsuranceCompany-attr-5-type" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(5,123)">Decimal</text><rect class="er attributeBoxOdd" fill="honeydew" fill-opacity="100%" stroke="gray" x="054.095550537109375" y="112" width="85.1038818359375" height="22"/><text class="er entityLabel" id="entity-InsuranceCompany-attr-5-name" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(59.095550537109375,123)">commissionRate</text><rect class="er attributeBoxEven" fill="honeydew" fill-opacity="100%" stroke="gray" x="0" y="134" width="54.095550537109375" height="22"/><text class="er entityLabel" id="entity-InsuranceCompany-attr-6-type" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(5,145)">DateTime</text><rect class="er attributeBoxEven" fill="honeydew" fill-opacity="100%" stroke="gray" x="054.095550537109375" y="134" width="85.1038818359375" height="22"/><text class="er entityLabel" id="entity-InsuranceCompany-attr-6-name" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(59.095550537109375,145)">createdAt</text><rect class="er attributeBoxOdd" fill="honeydew" fill-opacity="100%" stroke="gray" x="0" y="156" width="54.095550537109375" height="22"/><text class="er entityLabel" id="entity-InsuranceCompany-attr-7-type" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(5,167)">DateTime</text><rect class="er attributeBoxOdd" fill="honeydew" fill-opacity="100%" stroke="gray" x="054.095550537109375" y="156" width="85.1038818359375" height="22"/><text class="er entityLabel" id="entity-InsuranceCompany-attr-7-name" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(59.095550537109375,167)">updatedAt</text></g><g id="UserFeedback" transform="translate(740.3987884521484,565 )"><rect class="er entityBox" fill="honeydew" fill-opacity="100%" stroke="gray" x="0" y="0" width="177.9136505126953" height="112"/><text class="er entityLabel" id="entity-UserFeedback" x="0" y="0" dominant-baseline="middle" text-anchor="middle" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 12px" transform="translate(88.95682525634766,12)">UserFeedback</text><rect class="er attributeBoxOdd" fill="honeydew" fill-opacity="100%" stroke="gray" x="0" y="24" width="46.649749755859375" height="22"/><text class="er entityLabel" id="entity-UserFeedback-attr-1-type" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(5,35)">String</text><rect class="er attributeBoxOdd" fill="honeydew" fill-opacity="100%" stroke="gray" x="046.649749755859375" y="24" width="131.26390075683594" height="22"/><text class="er entityLabel" id="entity-UserFeedback-attr-1-name" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(51.649749755859375,35)">id</text><rect class="er attributeBoxEven" fill="honeydew" fill-opacity="100%" stroke="gray" x="0" y="46" width="46.649749755859375" height="22"/><text class="er entityLabel" id="entity-UserFeedback-attr-2-type" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(5,57)">String</text><rect class="er attributeBoxEven" fill="honeydew" fill-opacity="100%" stroke="gray" x="046.649749755859375" y="46" width="131.26390075683594" height="22"/><text class="er entityLabel" id="entity-UserFeedback-attr-2-name" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(51.649749755859375,57)">feedbackTitle</text><rect class="er attributeBoxOdd" fill="honeydew" fill-opacity="100%" stroke="gray" x="0" y="68" width="46.649749755859375" height="22"/><text class="er entityLabel" id="entity-UserFeedback-attr-3-type" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(5,79)">String</text><rect class="er attributeBoxOdd" fill="honeydew" fill-opacity="100%" stroke="gray" x="046.649749755859375" y="68" width="131.26390075683594" height="22"/><text class="er entityLabel" id="entity-UserFeedback-attr-3-name" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(51.649749755859375,79)">feedbackDescription</text><rect class="er attributeBoxEven" fill="honeydew" fill-opacity="100%" stroke="gray" x="0" y="90" width="46.649749755859375" height="22"/><text class="er entityLabel" id="entity-UserFeedback-attr-4-type" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(5,101)">Boolean</text><rect class="er attributeBoxEven" fill="honeydew" fill-opacity="100%" stroke="gray" x="046.649749755859375" y="90" width="131.26390075683594" height="22"/><text class="er entityLabel" id="entity-UserFeedback-attr-4-name" x="0" y="0" dominant-baseline="middle" text-anchor="left" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 10.2px" transform="translate(51.649749755859375,101)">recommendToOtherAgents</text></g><rect class="er relationshipLabelBox" x="133.69764709472656" y="778.1367797851562" width="23.958984375" height="14" fill="white" fill-opacity="85%"/><text class="er relationshipLabel" id="rel1" x="145.67713928222656" y="785.1367797851562" text-anchor="middle" dominant-baseline="middle" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 12px">user</text><rect class="er relationshipLabelBox" x="327.41455078125" y="747.5" width="23.958984375" height="14" fill="white" fill-opacity="85%"/><text class="er relationshipLabel" id="rel2" x="339.39404296875" y="754.5" text-anchor="middle" dominant-baseline="middle" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 12px">user</text><rect class="er relationshipLabelBox" x="91.56640625" y="486" width="30.4296875" height="14" fill="white" fill-opacity="85%"/><text class="er relationshipLabel" id="rel3" x="106.78125" y="493" text-anchor="middle" dominant-baseline="middle" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 12px">agent</text><rect class="er relationshipLabelBox" x="83.20637512207031" y="180.32101440429688" width="137.453125" height="14" fill="white" fill-opacity="85%"/><text class="er relationshipLabel" id="rel4" x="151.9329376220703" y="187.32101440429688" text-anchor="middle" dominant-baseline="middle" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 12px">monthlyRemittaceHistory</text><rect class="er relationshipLabelBox" x="468.05731201171875" y="170.90281677246094" width="92.8203125" height="14" fill="white" fill-opacity="85%"/><text class="er relationshipLabel" id="rel5" x="514.4674682617188" y="177.90281677246094" text-anchor="middle" dominant-baseline="middle" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 12px">insuranceProduct</text><rect class="er relationshipLabelBox" x="520.034423828125" y="475" width="101.529296875" height="14" fill="white" fill-opacity="85%"/><text class="er relationshipLabel" id="rel6" x="570.799072265625" y="482" text-anchor="middle" dominant-baseline="middle" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 12px">insuranceCompany</text><rect class="er relationshipLabelBox" x="645.578369140625" y="822.0582885742188" width="23.958984375" height="14" fill="white" fill-opacity="85%"/><text class="er relationshipLabel" id="rel7" x="657.557861328125" y="829.0582885742188" text-anchor="middle" dominant-baseline="middle" style="font-family: &quot;trebuchet ms&quot;, verdana, arial, sans-serif;; font-size: 12px">user</text></svg>.svg…]()
---

## 📁 Folder Structure

### Flutter (Mobile App)

```
lib/
├── core/                           # Shared utilities and tools
│   ├── constants/                  # App-wide constants
│   │   ├── api_constants.dart      # API endpoints and base URLs
│   │   ├── app_constants.dart      # Application constants (limits, defaults)
│   │   └── storage_constants.dart  # Local storage keys
│   ├── errors/                     # Error handling
│   │   ├── exceptions.dart         # Custom exception classes
│   │   └── failures.dart           # Failure classes for error states
│   ├── network/                    # Network layer
│   │   ├── api_client.dart         # ⭐ Centralized API client (GET, POST, PUT, DELETE)
│   │   ├── network_info.dart       # Internet connectivity checker
│   │   └── interceptors.dart       # HTTP interceptors (auth, logging)
│   ├── utils/                      # Utility functions
│   │   ├── validators.dart         # Input validation functions
│   │   ├── formatters.dart         # Data formatting utilities
│   │   └── date_helpers.dart       # Date manipulation helpers
│   ├── themes/                     # App theming
│   │   ├── app_theme.dart          # Theme configuration
│   │   ├── app_colors.dart         # Color palette
│   │   └── app_text_styles.dart    # Text styles
│   └── di/                         # Dependency injection
│       └── injection_container.dart # Service locator setup
│
├── data/                           # Data layer - handles data operations
│   ├── models/                     # Data models (API response/request)
│   │   ├── monthly_remittance_model.dart       # Monthly remittance data model with JSON serialization
│   │   ├── agent_model.dart        # Agent data model
│   ├── repositories/               # Repository implementations
│   │   ├── monthly_remittance_impl.dart
│   │   ├── agent_repository_impl.dart
│   └── datasources/                # Data sources (remote & local)
│       ├── remote/                 # API data sources
│       │   ├── monthly_remittance_remote_datasource.dart
│       │   ├── agent_remote_datasource.dart
│       └── local/                  # Local storage data sources
│           ├── monthly_remittance_local_datasource.dart
│           ├── agent_local_datasource.dart
│           └── app_database. dart   # Local database setup (Hive/SQLite)
│
├── domain/                         # Domain layer - business logic
│   ├── entities/                   # Pure business objects
│   │   ├── monthly_remittance.dart             # Monthly Remittance entity
│   │   ├── agent.dart              # Agent entity
│   ├── repositories/               # Repository interfaces (contracts)
│   │   ├── monthly_remittance_repository.dart
│   │   ├── agent_repository.dart
│   └── usecases/                   # Business use cases (single responsibility)
│       ├── monthly_remittance/
│       │   ├── get_monthly_remittances.dart
│       │   ├── get_monthly_remittance_details.dart
│       │   ├── create_monthly_remittance.dart
│       │   ├── update_monthly_remittance.dart
│       ├── agent/
│       │   ├── get_agents.dart
│       │   ├── get_agent_details.dart
│       │   └── update_agent_profile.dart
│
└── presentation/                   # Presentation layer - UI
    ├── pages/                      # Screen pages
    │   ├── splash/
    │   │   └── splash_page.dart
    │   ├── auth/
    │   │   ├── login_page.dart
    │   │   └── register_page.dart
    │   ├── dashboard/
    │   │   └── dashboard_page.dart
    │   ├── monthly_remittance/
    │   │   ├── monthly_remittance_list_page.dart
    │   │   ├── monthly_remittance_detail_page.dart
    ├── widgets/                    # Reusable UI components
    │   ├── common/
    │   │   ├── custom_button.dart
    │   │   ├── custom_text_field.dart
    │   │   ├── loading_indicator.dart
    │   │   └── error_widget.dart
    │   ├── monthly_remittance/
    │   │   └── monthly_remittance_card.dart
    └── providers/                  # State management (Provider pattern)
        ├── monthly_remittance/
        │   ├── monthly_remittance_provider.dart
        │   └── monthly_remittance_state.dart
        └── auth/
            ├── auth_provider.dart
            └── auth_state.dart
```

#### 📂 Folder Purpose Summary

| Folder | Purpose | When to Use |
|--------|---------|-------------|
| **core/** | Shared utilities used across the app | Place reusable tools, constants, API client |
| **data/** | Manages data from API and local storage | Create models, implement data fetching |
| **domain/** | Pure business logic, no framework dependencies | Define entities, business rules, use cases |
| **presentation/** | Everything user sees and interacts with | Build UI screens, widgets, state management |

---

### NestJS (Backend API)

```
src/
├── common/                         # Shared utilities across all modules
│   ├── decorators/                 # Custom decorators
│   │   ├── current-user.decorator.ts
│   │   └── roles.decorator.ts
│   ├── filters/                    # Exception filters
│   │   ├── http-exception.filter.ts
│   │   └── all-exceptions.filter.ts
│   ├── guards/                     # Route guards (authentication/authorization)
│   │   ├── jwt-auth.guard.ts
│   │   └── roles.guard.ts
│   ├── interceptors/               # Request/Response interceptors
│   │   ├── logging.interceptor.ts
│   │   └── transform.interceptor.ts
│   ├── pipes/                      # Validation pipes
│   │   └── validation.pipe.ts
│   ├── interfaces/                 # Shared TypeScript interfaces
│   │   └── response.interface.ts
│   └── constants/                  # Application constants
│       └── app.constants.ts
│
├── modules/                        # Feature modules
│   ├── auth/                       # Authentication module
│   │   ├── dto/
│   │   │   ├── login. dto.ts
│   │   │   ├── register.dto.ts
│   │   │   └── refresh-token.dto.ts
│   │   ├── auth.controller.ts      # Routes:  POST /auth/login, /auth/register
│   │   ├── auth.service.ts         # Business logic for authentication
│   │   └── auth.module.ts
│   │
│   ├── monthly_remittance/                   # Monthly Remittance module
│   │   ├── dto/
│   │   │   ├── create-monthly_remittance.dto.ts
│   │   │   ├── update-monthly_remittance.dto.ts
│   │   │   └── query-monthly_remittance.dto.ts
│   │   ├── monthly_remittance.controller.ts  # Routes: GET/POST/PUT/DELETE /policies
│   │   ├── monthly_remittance.service.ts     # Business logic for Monthly Remittance
│   │   └── monthly_remittance. module.ts
│   │
│   ├── agents/                     # Insurance agents module
│   │   ├── dto/
│   │   │   ├── create-agent.dto.ts
│   │   │   └── update-agent.dto.ts
│   │   ├── agents.controller.ts
│   │   ├── agents.service.ts
│   │   └── agents.module.ts
│   └── notifications/              # Push notifications module
│       ├── dto/
│       │   └── send-notification.dto.ts
│       ├── notifications.service.ts
│       └── notifications.module.ts
├── prisma/
│   ├── prisma.module.ts
│   └── prisma.service.ts
│
├── app.module.ts                   # Root application module
└── main.ts                         # Application entry point
```

#### 📂 NestJS Module Structure

Each module follows this pattern:

| File | Purpose | Example |
|------|---------|---------|
| **dto/** | Data Transfer Objects - validation schemas | Ensures incoming data is correct format |
| **entities/** | Database table definitions (TypeORM) | Defines what columns exist in the database |
| **controller. ts** | Handles HTTP requests (routes) | `GET /policies`, `POST /policies` |
| **service.ts** | Contains business logic | Calculates premiums, validates rules |
| **repository.ts** | Interacts with database | CRUD operations on database |
| **module.ts** | Bundles everything together | Exports the module to be used elsewhere |

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (>=3.0.0)
- Node.js (>=18.0.0)
- PostgreSQL (>=14.0)
- Firebase account (for notifications)

### Flutter Setup

```bash
# Clone the repository
git clone https://github.com/Pogs789/insurance-agent-remittance-engine.git

# Navigate to project directory
cd apps/mobile

# Install dependencies
flutter pub get

# Run the app
flutter run
```

### Backend Setup

```bash
# Navigate to backend directory
cd apps/backend

# Install dependencies
pnpm install

# Set up environment variables
cp .env.example . env
# Edit .env with your database credentials

# Run migrations
pnpm run migration: run

# Start the server
pnpm dev:backend
```

---

## 📡 API Documentation

### Base URL
```
Development: http://localhost:3000/api
Production: https://insurance-agent-remittance-engine-b.vercel.app/api
```

### Authentication
All protected routes require JWT token in the Authorization header:
```
Authorization: Bearer <your_jwt_token>
```

### Endpoints

#### Authentication
- `POST /auth/register` - Register new user
- `POST /auth/login` - Login user
- `POST /auth/refresh` - Refresh access token

#### Policies
- `GET /agent` - Get all agents
- `GET /agent/:id` - Get agent by ID
- `POST /agent` - Create new agent
- `PUT /agent/:id` - Update agent
- `DELETE /agent/:id` - Delete agent

#### Monthly Remittances
- `GET /monthly-remittances` - Get all monthly-remittances
- `GET /monthly-remittances/get-history/:agent-id` - Get all monthly-remittances by agent id
- `GET /monthly-remittances/:policyId` - Get all planholders for specific policy
- `POST /monthly-remittance/calculate` - Record premium payment
- `POST /monthly-remittance/upgate-calculation` - Calculate premium amount

---

## 🧪 Testing

### Flutter
```bash
# Run unit tests
flutter test

# Run integration tests
flutter test integration_test
```

### Backend
```bash
# Run unit tests
pnpm run test

# Run e2e tests
pnpm run test: e2e

# Test coverage
pnpm run test:cov
```

---

## 📱 Screenshots

<work in progress>

---

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/<your feature>`)
3. Commit your changes (`git commit -m 'What changes do you made.'`)
4. Push to the branch (`git push origin feature/<your feature>`)
5. Open a Pull Request

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 👨‍💻 Author

**Cesphillip M. Lorica**
- GitHub: [@yourusername](https://github.com/Pogs789)
- LinkedIn: [Your LinkedIn](https://www.linkedin.com/in/cesphillip-lorica-5923a523b/)
- Email: loricaphillip@outlook.com

---

## 🙏 Acknowledgments

- Insurance industry requirements gathered from an Insurance Agent, who inspired this project
- Clean Architecture principles by Robert C. Martin
- Flutter and NestJS communities

---

## 📊 Project Status

🚧 **Currently in development** - Version 1.0.0 coming soon!

- [x] Project structure setup
- [x] Blueprint and planning
- [x] Clean architecture implementation
- [ ] Authentication module
- [x] Remittance Calculation module
- [ ] User Management module
- [ ] Admin dashboard
- [ ] Testing coverage (>80%)
- [ ] Documentation completion
