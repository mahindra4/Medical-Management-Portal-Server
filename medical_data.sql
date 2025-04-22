--
-- PostgreSQL database dump
--

-- Dumped from database version 15.8
-- Dumped by pg_dump version 17.0

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: Day; Type: TYPE; Schema: public; Owner: login
--

CREATE TYPE public."Day" AS ENUM (
    'MONDAY',
    'TUESDAY',
    'WEDNESDAY',
    'THURSDAY',
    'FRIDAY',
    'SATURDAY',
    'SUNDAY'
);


ALTER TYPE public."Day" OWNER TO login;

--
-- Name: Department; Type: TYPE; Schema: public; Owner: login
--

CREATE TYPE public."Department" AS ENUM (
    'COMPUTER_SCIENCE',
    'ELECTRICAL',
    'MECHANICAL',
    'MATHEMATICS_COMPUTING',
    'CHEMICAL',
    'CIVIL',
    'METALLURGY',
    'ENGINEERING_PHYSICS',
    'PHYSICS',
    'CHEMISTRY',
    'BIOLOGY',
    'MATHEMATICS',
    'HUMANITIES'
);


ALTER TYPE public."Department" OWNER TO login;

--
-- Name: DoctorDepartment; Type: TYPE; Schema: public; Owner: login
--

CREATE TYPE public."DoctorDepartment" AS ENUM (
    'AYURVEDIC',
    'GYNECOLOGY',
    'HOMEOPATHY',
    'OTHERS'
);


ALTER TYPE public."DoctorDepartment" OWNER TO login;

--
-- Name: Gender; Type: TYPE; Schema: public; Owner: login
--

CREATE TYPE public."Gender" AS ENUM (
    'MALE',
    'FEMALE'
);


ALTER TYPE public."Gender" OWNER TO login;

--
-- Name: PatientCategory; Type: TYPE; Schema: public; Owner: login
--

CREATE TYPE public."PatientCategory" AS ENUM (
    'STUDENT',
    'FACULTY',
    'STAFF',
    'VISITOR'
);


ALTER TYPE public."PatientCategory" OWNER TO login;

--
-- Name: Program; Type: TYPE; Schema: public; Owner: login
--

CREATE TYPE public."Program" AS ENUM (
    'BTECH',
    'MTECH',
    'PHD',
    'DUAL_DEGREE'
);


ALTER TYPE public."Program" OWNER TO login;

--
-- Name: Role; Type: TYPE; Schema: public; Owner: login
--

CREATE TYPE public."Role" AS ENUM (
    'DOCTOR',
    'PARAMEDICAL'
);


ALTER TYPE public."Role" OWNER TO login;

--
-- Name: Shift; Type: TYPE; Schema: public; Owner: login
--

CREATE TYPE public."Shift" AS ENUM (
    'MORNING',
    'AFTERNOON',
    'NIGHT'
);


ALTER TYPE public."Shift" OWNER TO login;

--
-- Name: Status; Type: TYPE; Schema: public; Owner: login
--

CREATE TYPE public."Status" AS ENUM (
    'ACTIVE',
    'INACTIVE'
);


ALTER TYPE public."Status" OWNER TO login;

--
-- Name: UserRole; Type: TYPE; Schema: public; Owner: login
--

CREATE TYPE public."UserRole" AS ENUM (
    'DOCTOR',
    'PATIENT',
    'ADMIN',
    'PARAMEDICAL'
);


ALTER TYPE public."UserRole" OWNER TO login;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: OpdCounter; Type: TABLE; Schema: public; Owner: login
--

CREATE TABLE public."OpdCounter" (
    date text NOT NULL,
    count integer NOT NULL,
    id text NOT NULL
);


ALTER TABLE public."OpdCounter" OWNER TO login;

--
-- Name: Verification; Type: TABLE; Schema: public; Owner: login
--

CREATE TABLE public."Verification" (
    id text NOT NULL,
    email text NOT NULL,
    otp text NOT NULL,
    "expiryTime" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."Verification" OWNER TO login;

--
-- Name: _prisma_migrations; Type: TABLE; Schema: public; Owner: login
--

CREATE TABLE public._prisma_migrations (
    id character varying(36) NOT NULL,
    checksum character varying(64) NOT NULL,
    finished_at timestamp with time zone,
    migration_name character varying(255) NOT NULL,
    logs text,
    rolled_back_at timestamp with time zone,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    applied_steps_count integer DEFAULT 0 NOT NULL
);


ALTER TABLE public._prisma_migrations OWNER TO login;

--
-- Name: category; Type: TABLE; Schema: public; Owner: login
--

CREATE TABLE public.category (
    id text NOT NULL,
    "categoryName" text NOT NULL,
    "strengthType" text NOT NULL,
    status public."Status" DEFAULT 'ACTIVE'::public."Status" NOT NULL
);


ALTER TABLE public.category OWNER TO login;

--
-- Name: checkup; Type: TABLE; Schema: public; Owner: login
--

CREATE TABLE public.checkup (
    id text NOT NULL,
    "patientId" text NOT NULL,
    temperature double precision,
    date timestamp(3) without time zone NOT NULL,
    "bloodPressure" text,
    symptoms text,
    "doctorId" text,
    "staffId" text NOT NULL,
    diagnosis text NOT NULL,
    "pulseRate" integer,
    "spO2" double precision,
    "referredDoctor" text,
    "referredHospital" text
);


ALTER TABLE public.checkup OWNER TO login;

--
-- Name: checkupMedicine; Type: TABLE; Schema: public; Owner: login
--

CREATE TABLE public."checkupMedicine" (
    id text NOT NULL,
    "medicineId" text NOT NULL,
    dosage text,
    "checkupId" text NOT NULL,
    quantity integer NOT NULL
);


ALTER TABLE public."checkupMedicine" OWNER TO login;

--
-- Name: diagnosis_symptoms; Type: TABLE; Schema: public; Owner: login
--

CREATE TABLE public.diagnosis_symptoms (
    id text NOT NULL,
    diagnosis text NOT NULL,
    symptom text NOT NULL
);


ALTER TABLE public.diagnosis_symptoms OWNER TO login;

--
-- Name: hospitals; Type: TABLE; Schema: public; Owner: login
--

CREATE TABLE public.hospitals (
    id text NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.hospitals OWNER TO login;

--
-- Name: medicine; Type: TABLE; Schema: public; Owner: login
--

CREATE TABLE public.medicine (
    id text NOT NULL,
    "brandName" text NOT NULL,
    "saltName" text NOT NULL,
    "categoryId" text NOT NULL,
    status public."Status" DEFAULT 'ACTIVE'::public."Status" NOT NULL
);


ALTER TABLE public.medicine OWNER TO login;

--
-- Name: patient; Type: TABLE; Schema: public; Owner: login
--

CREATE TABLE public.patient (
    id text NOT NULL,
    name text NOT NULL,
    age integer NOT NULL,
    email text NOT NULL,
    "bloodGroup" text NOT NULL,
    "fatherOrSpouseName" text,
    category public."PatientCategory" NOT NULL,
    gender public."Gender" NOT NULL,
    allergy text,
    department public."Department",
    program public."Program",
    status public."Status" DEFAULT 'ACTIVE'::public."Status" NOT NULL
);


ALTER TABLE public.patient OWNER TO login;

--
-- Name: patient_vitals; Type: TABLE; Schema: public; Owner: login
--

CREATE TABLE public.patient_vitals (
    id text NOT NULL,
    "patientId" text NOT NULL,
    temperature double precision,
    date timestamp(3) without time zone NOT NULL,
    "bloodPressure" text,
    "pulseRate" integer,
    "spO2" double precision
);


ALTER TABLE public.patient_vitals OWNER TO login;

--
-- Name: purchase; Type: TABLE; Schema: public; Owner: login
--

CREATE TABLE public.purchase (
    id text NOT NULL,
    "batchNo" bigint NOT NULL,
    "expiryDate" timestamp(3) without time zone NOT NULL,
    "medicineId" text NOT NULL,
    "mfgDate" timestamp(3) without time zone,
    "purchaseListId" text NOT NULL,
    quantity integer NOT NULL
);


ALTER TABLE public.purchase OWNER TO login;

--
-- Name: purchaseList; Type: TABLE; Schema: public; Owner: login
--

CREATE TABLE public."purchaseList" (
    id text NOT NULL,
    "supplierId" text NOT NULL,
    "purchaseDate" timestamp(3) without time zone NOT NULL,
    "Details" text,
    "invoiceNo" bigint NOT NULL
);


ALTER TABLE public."purchaseList" OWNER TO login;

--
-- Name: requests; Type: TABLE; Schema: public; Owner: login
--

CREATE TABLE public.requests (
    id text NOT NULL,
    email text NOT NULL,
    name text NOT NULL,
    role public."UserRole" NOT NULL
);


ALTER TABLE public.requests OWNER TO login;

--
-- Name: schedule; Type: TABLE; Schema: public; Owner: login
--

CREATE TABLE public.schedule (
    id text NOT NULL,
    "staffId" text NOT NULL,
    shift public."Shift" NOT NULL,
    day public."Day" NOT NULL
);


ALTER TABLE public.schedule OWNER TO login;

--
-- Name: staff; Type: TABLE; Schema: public; Owner: login
--

CREATE TABLE public.staff (
    id text NOT NULL,
    name text NOT NULL,
    email text NOT NULL,
    role public."Role" NOT NULL,
    gender public."Gender" NOT NULL,
    department text,
    "mobileNumber" text,
    status public."Status" DEFAULT 'ACTIVE'::public."Status" NOT NULL,
    speciality text
);


ALTER TABLE public.staff OWNER TO login;

--
-- Name: stock; Type: TABLE; Schema: public; Owner: login
--

CREATE TABLE public.stock (
    id text NOT NULL,
    "medicineId" text NOT NULL,
    "inQuantity" integer NOT NULL,
    "outQuantity" integer NOT NULL,
    stock integer NOT NULL
);


ALTER TABLE public.stock OWNER TO login;

--
-- Name: supplier; Type: TABLE; Schema: public; Owner: login
--

CREATE TABLE public.supplier (
    id text NOT NULL,
    name text NOT NULL,
    address text NOT NULL,
    city text,
    state text NOT NULL,
    "mobileNumber" text NOT NULL,
    email text,
    "pinCode" integer,
    status public."Status" DEFAULT 'ACTIVE'::public."Status" NOT NULL
);


ALTER TABLE public.supplier OWNER TO login;

--
-- Name: user; Type: TABLE; Schema: public; Owner: login
--

CREATE TABLE public."user" (
    id text NOT NULL,
    email text NOT NULL,
    role public."UserRole" NOT NULL,
    name text NOT NULL,
    status public."Status" DEFAULT 'ACTIVE'::public."Status" NOT NULL
);


ALTER TABLE public."user" OWNER TO login;

--
-- Data for Name: OpdCounter; Type: TABLE DATA; Schema: public; Owner: login
--

COPY public."OpdCounter" (date, count, id) FROM stdin;
2025-04-21	29	1
\.


--
-- Data for Name: Verification; Type: TABLE DATA; Schema: public; Owner: login
--

COPY public."Verification" (id, email, otp, "expiryTime") FROM stdin;
5a2ffcfb-8eaa-4af1-b58d-f716c957f469	mahindrakatta4@gmail.com	0000	2025-04-08 21:33:57.094
\.


--
-- Data for Name: _prisma_migrations; Type: TABLE DATA; Schema: public; Owner: login
--

COPY public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) FROM stdin;
0601476f-8a7a-4df9-86ef-7b8f34ffcbf5	f260d8d12c35199639d1ae46e447015ddfd461f7db285d91eb1b87d1a5d965f3	2025-02-12 15:11:05.84544+05:30	20240303191502_mediease	\N	\N	2025-02-12 15:11:05.811833+05:30	1
be135aa7-e06a-413e-8b29-e0880ab0d746	765eb1e0c2cc30a26ce9b38112b031a67b9de05d6bb01b81dd19bbecc2c80f2c	2025-02-12 15:11:05.982126+05:30	20240330135159_added_check_medicine_model	\N	\N	2025-02-12 15:11:05.973031+05:30	1
7fb10b66-3b60-415b-afff-cc83fd18cb49	e080868a8457600fbc28999dffa5c92c09b32182a9beff68803b90756932ece2	2025-02-12 15:11:05.902431+05:30	20240310195541_	\N	\N	2025-02-12 15:11:05.845936+05:30	1
b75eb47a-e461-4b00-8292-f8d48c4c0329	8f6da696d34d841a9624aada1c5734d2136849458538afda7da96e77babc0113	2025-02-12 15:11:05.904876+05:30	20240312163217_minor_changes_in_checkup_model	\N	\N	2025-02-12 15:11:05.902798+05:30	1
da695515-fc68-4eb1-b4eb-7449923050bb	64401df35c0cc0b5cc86566d5503f1de44ed81f97db13091db3ce126c3ecb155	2025-02-12 15:11:05.916438+05:30	20240319121623_added_user_model	\N	\N	2025-02-12 15:11:05.905234+05:30	1
22e78145-7639-4437-b9e6-dd293c29a6ee	bd7e15ec5137b5ff053aa21f43db8ae6a82ba73f00fd7dab53056651cc56e69f	2025-02-12 15:11:05.988046+05:30	20240330142233_remove_redundant_relations_from_prisma_models	\N	\N	2025-02-12 15:11:05.982827+05:30	1
c4f18db8-e35c-4a2c-b40f-8cf31e6e1eb6	8b6ae5d308ddd10f54436673949cc27dc9b9a47914646c1e81032a9be100e108	2025-02-12 15:11:05.929058+05:30	20240319122246_added_map_block_identifier_for_new_models	\N	\N	2025-02-12 15:11:05.916824+05:30	1
8e9fec19-c514-4d99-b933-1bf229b40448	9d82bdb4fbc46ea065735d7a1bfa38f00cceac16f827bb8ee26a682f69f284c0	2025-02-12 15:11:05.931643+05:30	20240319125402_added_otp_and_expiry_in_user_model	\N	\N	2025-02-12 15:11:05.92943+05:30	1
8b1c7b87-6e24-4996-bfc1-23bd35e33590	b2eae026358af0feced3da74f24d51eb6627533de54ca5de6560cabc0173a208	2025-02-12 15:11:05.937689+05:30	20240319135334_made_email_unique_in_user_model	\N	\N	2025-02-12 15:11:05.932354+05:30	1
560160a2-db38-4a6a-a7a8-adb90de9c3ea	5ec7ad610c5dfc34130521c1901162d2846faa6b48960dd010f4ba135a757faf	2025-02-12 15:11:05.993572+05:30	20240331151124_change_type_of_inv_no_and_age	\N	\N	2025-02-12 15:11:05.988484+05:30	1
d8265abd-25f8-4749-ace3-a43c7ee50223	256d3fc4eb85b34186fdeeb0fdc2179535ee3fe3de2af93b42aef4d9819fbff5	2025-02-12 15:11:05.946623+05:30	20240319143516_added_verification_model	\N	\N	2025-02-12 15:11:05.938125+05:30	1
5fc55a2c-9f06-4313-8b77-8cafc5872fa5	5ca09594fa95e2932671eda2a1f282b9112fa09b624c5f51057d2cce3dd1feee	2025-02-12 15:11:05.950514+05:30	20240319144400_removed_unique_constraint_from_email_in_verification_model	\N	\N	2025-02-12 15:11:05.947017+05:30	1
77c09b60-16e4-4fca-8e71-bac3059202b2	65d3e594421bd6918ca7f4c75490d305577999a4b0a12bf8b4d6290f26ade4a2	2025-02-12 15:11:05.956042+05:30	20240319145351_refactor_verification_model	\N	\N	2025-02-12 15:11:05.951131+05:30	1
75a18486-90fc-4d3a-806a-a585a6be31ca	4185a7b9a3b8fc26d922a780a272541a0b85d1b9d91e75ad3fe260a39110f3b7	2025-02-12 15:11:05.99608+05:30	20240405095628_update_checkup_medicine	\N	\N	2025-02-12 15:11:05.99396+05:30	1
6db828f5-88f7-466c-919d-47962917da03	6e1bf06c48db00256bc0d590532f4629e7715e2ce4c3ae66d243695fc836cdd3	2025-02-12 15:11:05.958403+05:30	20240320044512_refactor_patient	\N	\N	2025-02-12 15:11:05.956556+05:30	1
cfaaee1d-dcc1-49f3-a09f-57416e75a4f4	9842343ad7d38410a5d5fcb7a38804b098582c05ebf8a4e5b1dbfcb2e62cd76a	2025-02-12 15:11:05.967331+05:30	20240321210057_add_requests_model	\N	\N	2025-02-12 15:11:05.958817+05:30	1
c593fb50-aa59-4f6b-b631-8b2bc5d92526	7add4466b88b39ea2b1e3a5567d87a49f3ca1a03817b31ff2b1658e68f3423f1	2025-02-12 15:11:05.972523+05:30	20240330104259_made_batch_no_unique	\N	\N	2025-02-12 15:11:05.9679+05:30	1
3d33d0ba-ab7f-49e3-a7dd-5eab40d9ff5f	2406284088910e33c2252f1fad61e2f708aec274810bc82c01b4464319889a8c	2025-02-12 15:11:05.998928+05:30	20240405201711_add_status_field	\N	\N	2025-02-12 15:11:05.996466+05:30	1
bd896e1e-bfbe-416d-9a70-dce4d003c1ee	89b962b237e0846b0923ce06cdc6a1e9e2384b961c7ee09f11e19da8d0c43ef5	2025-02-12 15:11:06.004679+05:30	20240406155733_made_mobile_no_unique	\N	\N	2025-02-12 15:11:05.999502+05:30	1
df0ebe0b-c4f6-4734-9cce-9a85ee1d3295	7fa5767dad486ba5c375979773d0db67b96e2e1bc2fa1e3bd627883f5ac02ec2	2025-02-12 15:11:06.008562+05:30	20240508211715_added_speciality_and_referral	\N	\N	2025-02-12 15:11:06.00517+05:30	1
f6b416ad-0373-4c34-9a59-062daaece34e	89b962b237e0846b0923ce06cdc6a1e9e2384b961c7ee09f11e19da8d0c43ef5	2025-02-12 15:11:06.013009+05:30	20240510193541_added_supplier_mobile_no_as_unique	\N	\N	2025-02-12 15:11:06.009037+05:30	1
bca6a43c-71b6-44e6-a4c2-0829e27c317c	9413fd4dd9718ee18fe23b5be4491b4cee4e7d191f23d5c0ab5bdb37309f2103	2025-03-19 00:12:56.752203+05:30	20250311123743_init	\N	\N	2025-03-19 00:12:56.741809+05:30	1
2447169a-6f84-4b16-9958-a695aecaf22d	76f02c48bffea43b94b2b256e29fceda96d92874235bd2ff70e08dde87668c26	2025-03-19 00:12:56.762068+05:30	20250318181118_init	\N	\N	2025-03-19 00:12:56.752735+05:30	1
f0c71969-dcfe-460a-b80c-e4b0e6e18af3	d3c2a576fac71cb214cf37f7263a7f9b83a249a7a199702b8ce4233b084d4bf3	2025-04-09 03:05:53.057225+05:30	20250408213553_opd_counter_updated	\N	\N	2025-04-09 03:05:53.035819+05:30	1
5674a357-4be0-461d-97a1-a35f2df5cf57	c3a7dfe202a2cdfea59045770ba2ed2fc03fe22e8d61426b646a1c71d23c72d7	2025-04-01 21:44:13.189038+05:30	20250401161413_add_patient_vitals	\N	\N	2025-04-01 21:44:13.168292+05:30	1
e99d1064-2392-4afb-a9fd-631af28d5a7b	7a5b8b7b7be160f0b294457b1f891d513b5bf8d00a37027fddf31389e6297821	2025-04-02 00:44:25.270917+05:30	20250401191425_patient_vitals_update	\N	\N	2025-04-02 00:44:25.266121+05:30	1
1ef853a8-5800-4298-9538-5cc8cc081b07	08acefc9dbe000ffcd0508b7791139bb13d2efbf3d139b31380bc82e9c5b44a8	2025-04-02 02:05:58.695409+05:30	20250401203558_patient_vitals_1	\N	\N	2025-04-02 02:05:58.682724+05:30	1
cce9d9b9-dbe7-487d-a04c-0fd673724795	3eb16d633452a0e52d45bcdfce4a0249c1749a320d29ca8bfb0f625db530ffc7	2025-04-09 03:15:31.880384+05:30	20250408214531_opd_max_final_change	\N	\N	2025-04-09 03:15:31.87716+05:30	1
ffba95d2-9afd-4a0d-8329-5f4bb8ed706a	0d0754e411b41413e470d8717e8c316fbaaf3f4ffcd30f82130bf1a56f66b1e8	2025-04-09 02:56:01.867388+05:30	20250408212601_opd_counter	\N	\N	2025-04-09 02:56:01.838516+05:30	1
e1dcbd4b-46a1-400b-9643-4fd478aa2869	5034a786a7a76eb63221d56290ae99015dd9a421aefd556f6e35afe5576ed62c	2025-04-09 03:40:07.393067+05:30	20250408221007_opd_counter_change	\N	\N	2025-04-09 03:40:07.377477+05:30	1
\.


--
-- Data for Name: category; Type: TABLE DATA; Schema: public; Owner: login
--

COPY public.category (id, "categoryName", "strengthType", status) FROM stdin;
C001	Pain Relievers	mg	ACTIVE
C002	Antibiotics	mg	ACTIVE
C003	Diabetes Medication	mg	ACTIVE
C004	Blood Pressure Medication	mg	ACTIVE
C005	Antipyretics	mg	ACTIVE
C006	Antacids	mg	ACTIVE
C007	Antihistamines	mg	ACTIVE
C008	Cholesterol Medication	mg	ACTIVE
C009	Vitamins & Supplements	mg	ACTIVE
fdd7d070-cd92-42e0-9e85-2134666c6f12	HYPNOTICS	grams	ACTIVE
\.


--
-- Data for Name: checkup; Type: TABLE DATA; Schema: public; Owner: login
--

COPY public.checkup (id, "patientId", temperature, date, "bloodPressure", symptoms, "doctorId", "staffId", diagnosis, "pulseRate", "spO2", "referredDoctor", "referredHospital") FROM stdin;
C002	cfbf601f-2487-4db3-a2c2-6e83c592d862	100.2	2025-03-04 14:00:00	130/85	Sore throat, cough	c7937db2-133b-427f-8367-603d57f11992	67b2f718-4a9e-4db3-8fdd-15f3754b2b6f	Throat Infection	80	97.8	\N	\N
bd6472a9-aee0-451a-8694-5f610fa408d3	cfbf601f-2487-4db3-a2c2-6e83c592d862	37	2025-03-05 15:44:55.857	127	\N	c7937db2-133b-427f-8367-603d57f11992	bae44353-9b1c-49f1-b832-93570f2de165	abc	180	56	\N	\N
03ed958a-81e7-4705-87f9-eef609802ea9	5e754e86-275e-45cf-bce3-65274de3c3b4	22	2025-03-06 12:46:33.559	170	\N	c7937db2-133b-427f-8367-603d57f11992	bae44353-9b1c-49f1-b832-93570f2de165	xyz	80	100	\N	\N
1fe4745a-6b8a-4a57-95cd-1ba47882b5cd	cfbf601f-2487-4db3-a2c2-6e83c592d862	22	2025-03-06 13:09:02.206	170	abc	c7937db2-133b-427f-8367-603d57f11992	bae44353-9b1c-49f1-b832-93570f2de165	abc	12	100	ab	abc
315b63f3-0118-4cc2-87a4-f770a69245e5	cfbf601f-2487-4db3-a2c2-6e83c592d862	22	2025-03-06 16:02:39.47	170	xyz	bae44353-9b1c-49f1-b832-93570f2de165	bae44353-9b1c-49f1-b832-93570f2de165	abc	100	80	doctor	hospital 
8d30c1a3-3f6d-4ba8-9ad1-fdf8b63a2eab	cfbf601f-2487-4db3-a2c2-6e83c592d862	100	2025-03-06 16:10:22.325	220	xyz	bae44353-9b1c-49f1-b832-93570f2de165	bae44353-9b1c-49f1-b832-93570f2de165	abc	79	80	a	b
b9bc2c05-6c25-4083-914c-569bf21a74a7	cfbf601f-2487-4db3-a2c2-6e83c592d862	100	2025-03-06 16:16:27.132	220	b	bae44353-9b1c-49f1-b832-93570f2de165	bae44353-9b1c-49f1-b832-93570f2de165	a	80	83	c	d
12621b35-1fb7-4f10-b43d-b6f53917f0df	cfbf601f-2487-4db3-a2c2-6e83c592d862	20	2025-03-13 18:45:16.908	20	\N	bae44353-9b1c-49f1-b832-93570f2de165	bae44353-9b1c-49f1-b832-93570f2de165	abc	10	20	\N	\N
7a75897a-2cdd-4645-a07c-b63f8653bc11	4919cc32-df6c-4be8-bcac-2f82328dec5e	202	2025-03-07 10:28:33.469	220	symptoms	c7937db2-133b-427f-8367-603d57f11992	67b2f718-4a9e-4db3-8fdd-15f3754b2b6f	uvwxy	105	85	a	b
35b6a326-daa3-49ca-8be6-de08650d8907	cfbf601f-2487-4db3-a2c2-6e83c592d862	\N	2025-03-06 10:58:36.263	\N	\N	\N	67b2f718-4a9e-4db3-8fdd-15f3754b2b6f	cough	\N	\N	\N	\N
a7d85953-6037-44bd-a17b-5fc9991b0b5c	cfbf601f-2487-4db3-a2c2-6e83c592d862	\N	2025-03-07 11:26:34.453	\N	\N	\N	c7937db2-133b-427f-8367-603d57f11992	aubdiuf	\N	\N	\N	\N
b93928a7-919e-4da1-b944-986dfb69429f	cfbf601f-2487-4db3-a2c2-6e83c592d862	100	2025-03-20 20:47:52.747	\N	Fever, Cough, Sore Throat, Body Aches, Fatigue, Frequent Urination, Increased Thirst, Unexplained Weight Loss, Fatigue, Blurred Vision	bae44353-9b1c-49f1-b832-93570f2de165	bae44353-9b1c-49f1-b832-93570f2de165	Flu, Diabetes	\N	100	\N	\N
d218a30f-2bf6-4064-ae92-eb2ff058a50f	cfbf601f-2487-4db3-a2c2-6e83c592d862	\N	2025-03-18 20:50:24.59	\N	Fever, Dry Cough, Loss of Taste, Loss of Smell, Shortness of Breath, Frequent Urination, Increased Thirst, Unexplained Weight Loss, Fatigue, Blurred Vision, eyes swelling	\N	bae44353-9b1c-49f1-b832-93570f2de165	COVID-19, Diabetes	\N	\N	\N	Apollo Clinic Mohali
35c4f053-ac18-47e5-86e1-ec0028502ff3	cfbf601f-2487-4db3-a2c2-6e83c592d862	\N	2025-03-19 05:36:28.3	\N	Runny Nose, Sneezing, Mild Cough, Sore Throat, Congestion, Shortness of Breath, Wheezing, Coughing at Night, Chest Tightness, Difficulty Breathing, Fever, Dry Cough, Loss of Taste, Loss of Smell, Shortness of Breath	\N	835d288b-deab-484a-9ec1-bf31157cc8ee	Common Cold, Asthma, COVID-19	\N	\N	\N	\N
a03b0b41-6c46-458b-83a5-2d6bb96c1bd2	cfbf601f-2487-4db3-a2c2-6e83c592d862	\N	2025-03-19 06:39:57.889	\N	Fever, Dry Cough, Loss of Taste, Loss of Smell, Shortness of Breath, Runny Nose, Sneezing, Mild Cough, Sore Throat, Congestion	\N	bae44353-9b1c-49f1-b832-93570f2de165	COVID-19, Common Cold	\N	\N	\N	\N
1d12bb38-16a5-4108-bfd6-dc99a89cac77	cfbf601f-2487-4db3-a2c2-6e83c592d862	\N	2025-04-01 09:33:37.697	\N	Fever, Dry Cough, Loss of Taste, Loss of Smell, Shortness of Breath, Chest Pain, Difficulty Breathing, Fatigue, Fever, Sweating	\N	835d288b-deab-484a-9ec1-bf31157cc8ee	COVID-19, Pneumonia	\N	\N	\N	Civil Hospital Rupnagar
C001	5e754e86-275e-45cf-bce3-65274de3c3b4	98.7	2025-03-05 00:00:00	120/80	Fever, headache	bae44353-9b1c-49f1-b832-93570f2de165	bae44353-9b1c-49f1-b832-93570f2de165	Viral Fever	75	98.5	\N	\N
27278d28-3161-4d69-a1da-89c83f3a1724	cfbf601f-2487-4db3-a2c2-6e83c592d862	27	2025-04-10 09:11:16.688	110	Fever, Dry Cough, Loss of Taste, Loss of Smell, Shortness of Breath, Shortness of Breath, Wheezing, Coughing at Night, Chest Tightness, Difficulty Breathing	\N	bae44353-9b1c-49f1-b832-93570f2de165	COVID-19, Asthma	83	40	\N	\N
OPD20250410-030	eba85a29-f4cf-418c-b5e8-11b7fc97a406	27	2025-04-10 09:25:58.742	170	Chest Pain, Difficulty Breathing, Fatigue, Fever, Sweating	\N	bae44353-9b1c-49f1-b832-93570f2de165	Pneumonia	80	100	\N	\N
OPD20250414-001	65814b95-b131-4e55-8c8e-f9533e12a756	15	2025-04-14 06:32:52.687	45	Fever, Dry Cough, Loss of Taste, Loss of Smell, Shortness of Breath, Shortness of Breath, Wheezing, Coughing at Night, Chest Tightness, Difficulty Breathing	c7937db2-133b-427f-8367-603d57f11992	835d288b-deab-484a-9ec1-bf31157cc8ee	COVID-19, Asthma	25	35	\N	\N
\.


--
-- Data for Name: checkupMedicine; Type: TABLE DATA; Schema: public; Owner: login
--

COPY public."checkupMedicine" (id, "medicineId", dosage, "checkupId", quantity) FROM stdin;
d8df6317-2d41-4c1e-b004-2f9d23605cc1	M001	10	bd6472a9-aee0-451a-8694-5f610fa408d3	5
dbff875e-1eb0-4eee-ac68-cf7759abc87d	M001	20	03ed958a-81e7-4705-87f9-eef609802ea9	10
d9f8dd7e-aee3-426a-96f6-4c458ed11afa	M002	150	1fe4745a-6b8a-4a57-95cd-1ba47882b5cd	7
a34f8e78-0139-4253-9a58-1b224d002fd9	M006	13	315b63f3-0118-4cc2-87a4-f770a69245e5	150
60dd81eb-1fde-4381-8272-0831048a0fd0	M007	90	8d30c1a3-3f6d-4ba8-9ad1-fdf8b63a2eab	18
c74d55dc-d274-4cd7-bdaf-8a595d1d2ce8	M005	20	b9bc2c05-6c25-4083-914c-569bf21a74a7	2
ec6b4f60-0d3e-4d39-91fc-10e8550d58e7	M008	10	12621b35-1fb7-4f10-b43d-b6f53917f0df	20
ea994290-1d5e-47ba-aad2-d6b5e5b2cab6	M013	10	7a75897a-2cdd-4645-a07c-b63f8653bc11	5
85d1d780-f405-44ab-ae4f-cb3e5996733d	M001	\N	35b6a326-daa3-49ca-8be6-de08650d8907	10
8c3278f8-ddef-43c9-8243-2dd012f46b71	M015	10	a7d85953-6037-44bd-a17b-5fc9991b0b5c	16
8d99ef44-f2f7-43b1-8a71-a108e0a294c7	M012	10	b93928a7-919e-4da1-b944-986dfb69429f	3
ae1a9d09-c809-4e74-b9b4-449481e2317a	M001	5	b93928a7-919e-4da1-b944-986dfb69429f	2
caad5376-13aa-4d6a-a469-5e10e3085975	M001	5	d218a30f-2bf6-4064-ae92-eb2ff058a50f	3
5344d11c-49ce-4056-8fb6-6ed6448a4529	M001	\N	35c4f053-ac18-47e5-86e1-ec0028502ff3	2
3fd66862-72c7-49f0-8393-f342c8dfe5bf	M003	\N	35c4f053-ac18-47e5-86e1-ec0028502ff3	3
a7b0d602-1e10-4df8-a2c0-f23c36899028	M009	\N	a03b0b41-6c46-458b-83a5-2d6bb96c1bd2	10
ffd65060-a0e6-418a-89c0-711cba2f54a7	M016	\N	1d12bb38-16a5-4108-bfd6-dc99a89cac77	7
2935616c-7790-425d-beaa-7de2d2cbaa8a	M014	10	27278d28-3161-4d69-a1da-89c83f3a1724	3
7114ebb6-a9a9-4ddd-9226-73f29a97ed05	M010	5	27278d28-3161-4d69-a1da-89c83f3a1724	2
959dc90e-3ade-4693-8760-c75291b702a4	M018	\N	OPD20250410-030	2
3988bba4-c916-4b72-962d-8b6f9f00e958	M020	3	OPD20250414-001	5
\.


--
-- Data for Name: diagnosis_symptoms; Type: TABLE DATA; Schema: public; Owner: login
--

COPY public.diagnosis_symptoms (id, diagnosis, symptom) FROM stdin;
1	Flu	Fever
2	Flu	Cough
3	Flu	Sore Throat
4	Flu	Body Aches
5	Flu	Fatigue
6	COVID-19	Fever
7	COVID-19	Dry Cough
8	COVID-19	Loss of Taste
9	COVID-19	Loss of Smell
10	COVID-19	Shortness of Breath
11	Common Cold	Runny Nose
12	Common Cold	Sneezing
13	Common Cold	Mild Cough
14	Common Cold	Sore Throat
15	Common Cold	Congestion
16	Pneumonia	Chest Pain
17	Pneumonia	Difficulty Breathing
18	Pneumonia	Fatigue
19	Pneumonia	Fever
20	Pneumonia	Sweating
21	Asthma	Shortness of Breath
22	Asthma	Wheezing
23	Asthma	Coughing at Night
24	Asthma	Chest Tightness
25	Asthma	Difficulty Breathing
26	Diabetes	Frequent Urination
27	Diabetes	Increased Thirst
28	Diabetes	Unexplained Weight Loss
29	Diabetes	Fatigue
30	Diabetes	Blurred Vision
31	Hypertension	Headaches
32	Hypertension	Dizziness
33	Hypertension	Shortness of Breath
34	Hypertension	Nosebleeds
35	Hypertension	Chest Pain
36	Migraine	Severe Headache
37	Migraine	Nausea
38	Migraine	Sensitivity to Light
39	Migraine	Vomiting
40	Migraine	Blurred Vision
41	Tuberculosis	Persistent Cough
42	Tuberculosis	Night Sweats
43	Tuberculosis	Weight Loss
44	Tuberculosis	Fever
45	Tuberculosis	Fatigue
46	Anemia	Pale Skin
47	Anemia	Shortness of Breath
48	Anemia	Fatigue
49	Anemia	Dizziness
50	Anemia	Cold Hands and Feet
51	Food Poisoning	Nausea
52	Food Poisoning	Vomiting
53	Food Poisoning	Diarrhea
54	Food Poisoning	Abdominal Pain
55	Food Poisoning	Fever
56	Heart Attack	Chest Pain
57	Heart Attack	Shortness of Breath
58	Heart Attack	Nausea
59	Heart Attack	Cold Sweat
60	Heart Attack	Dizziness
\.


--
-- Data for Name: hospitals; Type: TABLE DATA; Schema: public; Owner: login
--

COPY public.hospitals (id, name) FROM stdin;
1	Pusha Hospital
2	Civil Hospital Rupnagar
3	PGIMER Chandigarh
4	Government Medical College and Hospital (GMCH) Chandigarh
5	SPS Hospitals Ludhiana
6	Neelam Hospital Ludhiana
7	Apollo Clinic Mohali
8	Fortis Hospital Mohali
9	Max Super Specialty Hospital Mohali
10	IVY Hospital Mohali
11	Gian Sagar Hospital Banur
12	Chandigarh City Hospital
13	Santokh Hospital Chandigarh
14	Shalby Hospital Mohali
15	Greencity Hospital Ludhiana
16	Kakkar Hospital Amritsar
17	Healing Hospital Chandigarh
18	Dayanand Medical College & Hospital Ludhiana
19	IVY Hospital Nawanshahr
20	Rajindra Hospital Patiala
21	Sohana Hospital Mohali
22	Bansal Hospital Ludhiana
23	Sanjeevni Hospital Jalandhar
24	Sidhu Hospital Patiala
25	Silver Oaks Hospital Mohali
26	Kular Hospital Jalandhar
27	Guru Nanak Mission Hospital Jalandhar
28	Rattan Hospital Ludhiana
29	Jeevan Jot Hospital Amritsar
30	Shri Guru Ram Das Charitable Hospital Amritsar
31	Hargun Hospital Amritsar
32	Chawla Hospital Amritsar
33	IVY Hospital Amritsar
34	Mukat Hospital Chandigarh
35	City Hospital Moga
36	Narang Eye Hospital Jalandhar
37	Jaspal Hospital Bathinda
38	Jalandhar Hospital Jalandhar
39	Khurana Eye Hospital Ludhiana
40	Bharti Hospital Patiala
41	Kang Eye Hospital Moga
42	Arora Neuro Centre Ludhiana
43	Healing Touch Hospital Jalandhar
44	Civil Hospital Jalandhar
45	Guru Teg Bahadur Hospital Ludhiana
46	Baba Budha Ji Hospital Tarn Taran
47	Hargun Hospital Tarn Taran
48	Bhagat Hospital Ludhiana
49	IVY Hospital Khanna
50	Mahajan Eye Hospital Ludhiana
51	Verma Hospital Moga
52	Sangha Hospital Phagwara
53	Bhatti Hospital Hoshiarpur
54	Civil Hospital Pathankot
55	Shivam Hospital Ferozepur
56	Aggarwal Hospital Batala
57	Shri Krishna Hospital Gurdaspur
58	Kapoor Hospital Phagwara
59	Civil Hospital Ludhiana
60	Ravindra Hospital Jalandhar
\.


--
-- Data for Name: medicine; Type: TABLE DATA; Schema: public; Owner: login
--

COPY public.medicine (id, "brandName", "saltName", "categoryId", status) FROM stdin;
M001	Paracetamol	Acetaminophen	C001	ACTIVE
M002	Augmentin	Amoxicillin + Clavulanic Acid	C002	ACTIVE
M003	Azithromycin	Azithromycin Dihydrate	C002	ACTIVE
M004	Metformin	Metformin Hydrochloride	C003	ACTIVE
M005	Losartan	Losartan Potassium	C004	ACTIVE
M006	Ibuprofen	Ibuprofen	C001	ACTIVE
M007	Aspirin	Acetylsalicylic Acid	C001	ACTIVE
M008	Ciprofloxacin	Ciprofloxacin Hydrochloride	C002	ACTIVE
M009	Doxycycline	Doxycycline Hyclate	C002	ACTIVE
M010	Glipizide	Glipizide	C003	ACTIVE
M011	Sitagliptin	Sitagliptin Phosphate	C003	ACTIVE
M012	Amlodipine	Amlodipine Besylate	C004	ACTIVE
M013	Hydrochlorothiazide	Hydrochlorothiazide	C004	ACTIVE
M014	Nimesulide	Nimesulide	C005	ACTIVE
M015	Metamizole	Metamizole Sodium	C005	ACTIVE
M016	Omeprazole	Omeprazole	C006	ACTIVE
M017	Ranitidine	Ranitidine Hydrochloride	C006	ACTIVE
M018	Loratadine	Loratadine	C007	ACTIVE
M019	Cetirizine	Cetirizine Hydrochloride	C007	ACTIVE
M020	Atorvastatin	Atorvastatin Calcium	C008	ACTIVE
M021	Rosuvastatin	Rosuvastatin Calcium	C008	ACTIVE
M022	Vitamin C	Ascorbic Acid	C009	ACTIVE
M023	Vitamin D3	Cholecalciferol	C009	ACTIVE
d027fd83-fb53-4ca9-9d36-9ad5c3e72a95	parzol	hypnosis	fdd7d070-cd92-42e0-9e85-2134666c6f12	ACTIVE
\.


--
-- Data for Name: patient; Type: TABLE DATA; Schema: public; Owner: login
--

COPY public.patient (id, name, age, email, "bloodGroup", "fatherOrSpouseName", category, gender, allergy, department, program, status) FROM stdin;
5e754e86-275e-45cf-bce3-65274de3c3b4	joe	18	joe@gmail.com	B-	\N	VISITOR	MALE	\N	COMPUTER_SCIENCE	BTECH	ACTIVE
cfbf601f-2487-4db3-a2c2-6e83c592d862	mahindra	19	2022csb1088@iitrpr.ac.in	AB-	joe	STUDENT	MALE	no	COMPUTER_SCIENCE	BTECH	ACTIVE
eba85a29-f4cf-418c-b5e8-11b7fc97a406	nick	19	nick@whale.com	A+	\N	STUDENT	MALE	\N	COMPUTER_SCIENCE	BTECH	ACTIVE
4919cc32-df6c-4be8-bcac-2f82328dec5e	abc	19	b@gmail.com	B+	def	FACULTY	FEMALE	no	ELECTRICAL	PHD	ACTIVE
7fe7f077-1dfe-444e-b846-87d56c03c31b	joe	19	joe@joe.com	O-	none	STUDENT	MALE	none	COMPUTER_SCIENCE	PHD	ACTIVE
98142fc3-272c-4d77-b1d5-e77a8d90729b	joe	20	jam@gmailc.om	AB+	\N	STAFF	MALE	\N	MECHANICAL	\N	ACTIVE
65814b95-b131-4e55-8c8e-f9533e12a756	john	20	john@john.jo	AB+	alice	FACULTY	MALE	none	CHEMICAL	MTECH	ACTIVE
eb499c38-6ab0-4f8a-815c-207c9192ce01	peter	40	peter@peter.pet	A+	\N	STAFF	MALE	no	BIOLOGY	PHD	ACTIVE
\.


--
-- Data for Name: patient_vitals; Type: TABLE DATA; Schema: public; Owner: login
--

COPY public.patient_vitals (id, "patientId", temperature, date, "bloodPressure", "pulseRate", "spO2") FROM stdin;
OPD20250409-001	eba85a29-f4cf-418c-b5e8-11b7fc97a406	27	2025-04-09 04:52:12	162	93	53
OPD20250409-002	eba85a29-f4cf-418c-b5e8-11b7fc97a406	27	2025-04-09 04:52:26	162	93	53
OPD20250409-005	eba85a29-f4cf-418c-b5e8-11b7fc97a406	27	2025-04-09 04:52:28	162	93	53
OPD20250409-008	eba85a29-f4cf-418c-b5e8-11b7fc97a406	27	2025-04-09 04:56:00	162	93	53
OPD20250421-001	cfbf601f-2487-4db3-a2c2-6e83c592d862	22	2025-04-21 12:38:19.554	120	83	43
OPD20250409-010	65814b95-b131-4e55-8c8e-f9533e12a756	27	2025-04-09 05:41:14.134	163	93	53
OPD20250410-015	cfbf601f-2487-4db3-a2c2-6e83c592d862	\N	2025-04-10 09:07:27.092	\N	\N	\N
OPD20250410-001	cfbf601f-2487-4db3-a2c2-6e83c592d862	\N	2025-04-10 07:49:03.807	\N	\N	\N
OPD20250410-003	cfbf601f-2487-4db3-a2c2-6e83c592d862	\N	2025-04-10 07:51:46	\N	\N	\N
OPD20250410-004	cfbf601f-2487-4db3-a2c2-6e83c592d862	\N	2025-04-10 07:54:14	\N	\N	\N
OPD20250410-005	cfbf601f-2487-4db3-a2c2-6e83c592d862	\N	2025-04-10 07:54:32	\N	\N	\N
OPD20250410-006	cfbf601f-2487-4db3-a2c2-6e83c592d862	\N	2025-04-10 07:55:02	\N	\N	\N
OPD20250410-007	cfbf601f-2487-4db3-a2c2-6e83c592d862	\N	2025-04-10 07:55:32	\N	\N	\N
OPD20250402-002	cfbf601f-2487-4db3-a2c2-6e83c592d862	22	2025-04-01 19:37:17.505	170	1	100
OPD20250402-003	cfbf601f-2487-4db3-a2c2-6e83c592d862	22	2025-04-01 19:37:29.381	170	1	100
OPD20250402-004	cfbf601f-2487-4db3-a2c2-6e83c592d862	22	2025-04-01 19:39:00.137	170	1	\N
OPD20250402-005	cfbf601f-2487-4db3-a2c2-6e83c592d862	22	2025-04-01 20:36:36.605	170	1	100
OPD20250402-006	cfbf601f-2487-4db3-a2c2-6e83c592d862	22	2025-04-01 20:36:37.538	170	1	100
OPD20250402-007	cfbf601f-2487-4db3-a2c2-6e83c592d862	22	2025-04-01 20:36:38.38	170	1	100
OPD20250402-008	cfbf601f-2487-4db3-a2c2-6e83c592d862	\N	2025-04-02 04:47:51.726	\N	\N	\N
OPD20250402-009	cfbf601f-2487-4db3-a2c2-6e83c592d862	22	2025-04-02 07:00:26.309	170	82	76
OPD20250402-010	7fe7f077-1dfe-444e-b846-87d56c03c31b	22	2025-04-02 07:36:18.23	170	82	76
OPD20250402-011	7fe7f077-1dfe-444e-b846-87d56c03c31b	22	2025-04-02 07:36:19.844	170	82	76
OPD20250403-001	98142fc3-272c-4d77-b1d5-e77a8d90729b	22	2025-04-03 12:21:22.65	120	80	70
OPD20250403-002	98142fc3-272c-4d77-b1d5-e77a8d90729b	22	2025-04-03 12:56:12.605	120	80	70
OPD20250403-003	eb499c38-6ab0-4f8a-815c-207c9192ce01	22	2025-04-03 13:12:01.321	120	80	70
OPD20250410-008	cfbf601f-2487-4db3-a2c2-6e83c592d862	\N	2025-04-10 08:03:17.421	\N	\N	\N
OPD20250410-030	eba85a29-f4cf-418c-b5e8-11b7fc97a406	27	2025-04-10 09:25:54.614	170	80	100
OPD20250421-018	cfbf601f-2487-4db3-a2c2-6e83c592d862	22	2025-04-21 12:41:17.086	120	83	43
OPD20250414-001	65814b95-b131-4e55-8c8e-f9533e12a756	15	2025-04-14 06:32:52.687	45	25	35
\.


--
-- Data for Name: purchase; Type: TABLE DATA; Schema: public; Owner: login
--

COPY public.purchase (id, "batchNo", "expiryDate", "medicineId", "mfgDate", "purchaseListId", quantity) FROM stdin;
1cc8cbd2-566c-4ee6-a8d7-d95f3bdd449f	1207	2025-03-29 00:00:00	M001	2025-02-07 00:00:00	71497aaf-8046-4024-974c-1f570e206975	20
b4a8846a-21f8-47de-a54c-dd30b27559f2	35	2025-03-06 00:00:00	M011	2024-04-10 00:00:00	85db04b7-4c65-4557-9295-785ca81bd40f	20
\.


--
-- Data for Name: purchaseList; Type: TABLE DATA; Schema: public; Owner: login
--

COPY public."purchaseList" (id, "supplierId", "purchaseDate", "Details", "invoiceNo") FROM stdin;
71497aaf-8046-4024-974c-1f570e206975	e8e4b398-ba37-45db-9083-e5d5b269e315	2025-03-07 00:00:00	\N	10
85db04b7-4c65-4557-9295-785ca81bd40f	62f3baf3-27c8-4d2f-86d2-de211a71853d	2025-03-04 00:00:00	\N	102
\.


--
-- Data for Name: requests; Type: TABLE DATA; Schema: public; Owner: login
--

COPY public.requests (id, email, name, role) FROM stdin;
8f7096c9-7c0e-400c-8595-6557b6bde062	2022csb1088+max@iitrpr.ac.in	max	DOCTOR
526d4eb5-a70a-48db-a801-e9103a23250d	2022csb1088+bob@gmail.com	bob	PARAMEDICAL
\.


--
-- Data for Name: schedule; Type: TABLE DATA; Schema: public; Owner: login
--

COPY public.schedule (id, "staffId", shift, day) FROM stdin;
94f77fff-926e-4a3b-8c2a-d3a46e012c57	bae44353-9b1c-49f1-b832-93570f2de165	MORNING	WEDNESDAY
38c5074d-d229-43a8-bad7-e2f71d261c7f	bae44353-9b1c-49f1-b832-93570f2de165	AFTERNOON	TUESDAY
969ae23c-eabd-44fc-8c12-67c2415d4bde	bae44353-9b1c-49f1-b832-93570f2de165	AFTERNOON	THURSDAY
082b0ce0-2962-466a-acc2-64a25038dee5	67b2f718-4a9e-4db3-8fdd-15f3754b2b6f	MORNING	SATURDAY
60b62755-58c2-47cc-ba7e-2d2c587eb418	67b2f718-4a9e-4db3-8fdd-15f3754b2b6f	NIGHT	SATURDAY
45e10625-3807-44c3-9e61-1bab5bab9dfc	bae44353-9b1c-49f1-b832-93570f2de165	AFTERNOON	FRIDAY
\.


--
-- Data for Name: staff; Type: TABLE DATA; Schema: public; Owner: login
--

COPY public.staff (id, name, email, role, gender, department, "mobileNumber", status, speciality) FROM stdin;
c7937db2-133b-427f-8367-603d57f11992	vasu	2022csb1150@iitrpr.ac.in	DOCTOR	MALE	HOMEOPATHY	\N	ACTIVE	\N
67b2f718-4a9e-4db3-8fdd-15f3754b2b6f	vasu ram	vasuram63027@gmail.com	PARAMEDICAL	MALE	\N	\N	ACTIVE	\N
bae44353-9b1c-49f1-b832-93570f2de165	nobita	nobita@gmail.com	DOCTOR	MALE	HOMEOPATHY	\N	ACTIVE	cardio
bf18778c-cb63-4f86-a126-1f578e00d99e	nick	nick@nick.co	PARAMEDICAL	MALE	\N	1234567890	ACTIVE	\N
835d288b-deab-484a-9ec1-bf31157cc8ee	bob	2022csb1088+bob@iitrpr.ac.in	PARAMEDICAL	MALE	\N	\N	ACTIVE	\N
\.


--
-- Data for Name: stock; Type: TABLE DATA; Schema: public; Owner: login
--

COPY public.stock (id, "medicineId", "inQuantity", "outQuantity", stock) FROM stdin;
S004	M004	120	30	90
S017	M017	170	65	105
S019	M019	190	75	115
S021	M021	210	85	125
S022	M022	220	90	130
S023	M023	230	95	135
S002	M002	50	17	33
S006	M006	200	200	0
S007	M007	180	58	122
S005	M005	90	27	63
S008	M008	75	35	40
S011	M011	115	30	85
S013	M013	130	40	90
S015	M015	155	66	89
S012	M012	110	28	82
S001	M001	120	52	68
S003	M003	70	18	52
S009	M009	60	20	40
S016	M016	160	67	93
S014	M014	140	43	97
S010	M010	85	22	63
S018	M018	180	72	108
S020	M020	200	85	115
\.


--
-- Data for Name: supplier; Type: TABLE DATA; Schema: public; Owner: login
--

COPY public.supplier (id, name, address, city, state, "mobileNumber", email, "pinCode", status) FROM stdin;
e8e4b398-ba37-45db-9083-e5d5b269e315	joe 	iitropar,punjab 	chandigarh	punjab	1234567890	joe@gmail.com	140001	ACTIVE
62f3baf3-27c8-4d2f-86d2-de211a71853d	john	mumbai 	mumbai	maharastra	1234567891	john@john.cm	140001	ACTIVE
c5c3271e-d328-4bb8-b11c-8bd1e344a06b	abc	line 1 line 2	mumbai	maharastra	1919191919	ab@ab.com	123453	ACTIVE
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: login
--

COPY public."user" (id, email, role, name, status) FROM stdin;
1	mahindrakatta4@gmail.com	ADMIN	mahindra	ACTIVE
b84234fe-85f0-4724-a623-37f8742015ba	joe@gmail.com	PATIENT	joe	ACTIVE
58ec9828-ba54-4a4e-b048-79da496de0c3	2022csb1088@iitrpr.ac.in	PATIENT	mahindra	ACTIVE
2	2022csb1150@iitrpr.ac.in	DOCTOR	vasu	ACTIVE
ee8a3247-2c6c-4a12-8e23-1a5bdced4210	nobita@gmail.com	DOCTOR	nobita	ACTIVE
70ea58b6-2261-4a63-b0c7-4ed7d4f0fade	nick@whale.com	PATIENT	nick	ACTIVE
071daa97-edba-4652-9e8a-2653f2ce226a	b@gmail.com	PATIENT	abc	ACTIVE
fb4762cd-986e-470f-90bb-bf30094e78ca	joe@joe.com	PATIENT	joe	ACTIVE
cad574ee-e793-4f76-a609-8a71da1a2aa4	jam@gmailc.om	PATIENT	joe	ACTIVE
8d34bcb4-c7fe-4dcf-b4d1-4746eda5383e	nick@nick.co	PARAMEDICAL	nick	ACTIVE
09400a7d-8b68-4c25-9972-2eae5fea98e0	john@john.jo	PATIENT	john	ACTIVE
176c5192-8202-45eb-ba6a-c8ef5b0efb05	peter@peter.pet	PATIENT	peter	ACTIVE
3	vasuram63027@gmail.com	ADMIN	vasu ram	ACTIVE
c4a0a137-3542-4382-8d65-019ba253179d	2022csb1088+bob@iitrpr.ac.in	PARAMEDICAL	bob	ACTIVE
\.


--
-- Name: OpdCounter OpdCounter_pkey; Type: CONSTRAINT; Schema: public; Owner: login
--

ALTER TABLE ONLY public."OpdCounter"
    ADD CONSTRAINT "OpdCounter_pkey" PRIMARY KEY (id);


--
-- Name: Verification Verification_pkey; Type: CONSTRAINT; Schema: public; Owner: login
--

ALTER TABLE ONLY public."Verification"
    ADD CONSTRAINT "Verification_pkey" PRIMARY KEY (id);


--
-- Name: _prisma_migrations _prisma_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: login
--

ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);


--
-- Name: category category_pkey; Type: CONSTRAINT; Schema: public; Owner: login
--

ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_pkey PRIMARY KEY (id);


--
-- Name: checkupMedicine checkupMedicine_pkey; Type: CONSTRAINT; Schema: public; Owner: login
--

ALTER TABLE ONLY public."checkupMedicine"
    ADD CONSTRAINT "checkupMedicine_pkey" PRIMARY KEY (id);


--
-- Name: checkup checkup_pkey; Type: CONSTRAINT; Schema: public; Owner: login
--

ALTER TABLE ONLY public.checkup
    ADD CONSTRAINT checkup_pkey PRIMARY KEY (id);


--
-- Name: diagnosis_symptoms diagnosis_symptoms_pkey; Type: CONSTRAINT; Schema: public; Owner: login
--

ALTER TABLE ONLY public.diagnosis_symptoms
    ADD CONSTRAINT diagnosis_symptoms_pkey PRIMARY KEY (id);


--
-- Name: hospitals hospitals_pkey; Type: CONSTRAINT; Schema: public; Owner: login
--

ALTER TABLE ONLY public.hospitals
    ADD CONSTRAINT hospitals_pkey PRIMARY KEY (id);


--
-- Name: medicine medicine_pkey; Type: CONSTRAINT; Schema: public; Owner: login
--

ALTER TABLE ONLY public.medicine
    ADD CONSTRAINT medicine_pkey PRIMARY KEY (id);


--
-- Name: patient patient_pkey; Type: CONSTRAINT; Schema: public; Owner: login
--

ALTER TABLE ONLY public.patient
    ADD CONSTRAINT patient_pkey PRIMARY KEY (id);


--
-- Name: patient_vitals patient_vitals_pkey; Type: CONSTRAINT; Schema: public; Owner: login
--

ALTER TABLE ONLY public.patient_vitals
    ADD CONSTRAINT patient_vitals_pkey PRIMARY KEY (id);


--
-- Name: purchaseList purchaseList_pkey; Type: CONSTRAINT; Schema: public; Owner: login
--

ALTER TABLE ONLY public."purchaseList"
    ADD CONSTRAINT "purchaseList_pkey" PRIMARY KEY (id);


--
-- Name: purchase purchase_pkey; Type: CONSTRAINT; Schema: public; Owner: login
--

ALTER TABLE ONLY public.purchase
    ADD CONSTRAINT purchase_pkey PRIMARY KEY (id);


--
-- Name: requests requests_pkey; Type: CONSTRAINT; Schema: public; Owner: login
--

ALTER TABLE ONLY public.requests
    ADD CONSTRAINT requests_pkey PRIMARY KEY (id);


--
-- Name: schedule schedule_pkey; Type: CONSTRAINT; Schema: public; Owner: login
--

ALTER TABLE ONLY public.schedule
    ADD CONSTRAINT schedule_pkey PRIMARY KEY (id);


--
-- Name: staff staff_pkey; Type: CONSTRAINT; Schema: public; Owner: login
--

ALTER TABLE ONLY public.staff
    ADD CONSTRAINT staff_pkey PRIMARY KEY (id);


--
-- Name: stock stock_pkey; Type: CONSTRAINT; Schema: public; Owner: login
--

ALTER TABLE ONLY public.stock
    ADD CONSTRAINT stock_pkey PRIMARY KEY (id);


--
-- Name: supplier supplier_pkey; Type: CONSTRAINT; Schema: public; Owner: login
--

ALTER TABLE ONLY public.supplier
    ADD CONSTRAINT supplier_pkey PRIMARY KEY (id);


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: login
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: Verification_email_key; Type: INDEX; Schema: public; Owner: login
--

CREATE UNIQUE INDEX "Verification_email_key" ON public."Verification" USING btree (email);


--
-- Name: patient_email_key; Type: INDEX; Schema: public; Owner: login
--

CREATE UNIQUE INDEX patient_email_key ON public.patient USING btree (email);


--
-- Name: purchaseList_invoiceNo_key; Type: INDEX; Schema: public; Owner: login
--

CREATE UNIQUE INDEX "purchaseList_invoiceNo_key" ON public."purchaseList" USING btree ("invoiceNo");


--
-- Name: purchase_batchNo_key; Type: INDEX; Schema: public; Owner: login
--

CREATE UNIQUE INDEX "purchase_batchNo_key" ON public.purchase USING btree ("batchNo");


--
-- Name: requests_email_key; Type: INDEX; Schema: public; Owner: login
--

CREATE UNIQUE INDEX requests_email_key ON public.requests USING btree (email);


--
-- Name: staff_email_key; Type: INDEX; Schema: public; Owner: login
--

CREATE UNIQUE INDEX staff_email_key ON public.staff USING btree (email);


--
-- Name: supplier_mobileNumber_key; Type: INDEX; Schema: public; Owner: login
--

CREATE UNIQUE INDEX "supplier_mobileNumber_key" ON public.supplier USING btree ("mobileNumber");


--
-- Name: user_email_key; Type: INDEX; Schema: public; Owner: login
--

CREATE UNIQUE INDEX user_email_key ON public."user" USING btree (email);


--
-- Name: checkupMedicine checkupMedicine_checkupId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: login
--

ALTER TABLE ONLY public."checkupMedicine"
    ADD CONSTRAINT "checkupMedicine_checkupId_fkey" FOREIGN KEY ("checkupId") REFERENCES public.checkup(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: checkupMedicine checkupMedicine_medicineId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: login
--

ALTER TABLE ONLY public."checkupMedicine"
    ADD CONSTRAINT "checkupMedicine_medicineId_fkey" FOREIGN KEY ("medicineId") REFERENCES public.medicine(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: checkup checkup_doctorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: login
--

ALTER TABLE ONLY public.checkup
    ADD CONSTRAINT "checkup_doctorId_fkey" FOREIGN KEY ("doctorId") REFERENCES public.staff(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: checkup checkup_patientId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: login
--

ALTER TABLE ONLY public.checkup
    ADD CONSTRAINT "checkup_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES public.patient(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: checkup checkup_staffId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: login
--

ALTER TABLE ONLY public.checkup
    ADD CONSTRAINT "checkup_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES public.staff(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: medicine medicine_categoryId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: login
--

ALTER TABLE ONLY public.medicine
    ADD CONSTRAINT "medicine_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES public.category(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: patient_vitals patient_vitals_patientId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: login
--

ALTER TABLE ONLY public.patient_vitals
    ADD CONSTRAINT "patient_vitals_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES public.patient(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: purchaseList purchaseList_supplierId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: login
--

ALTER TABLE ONLY public."purchaseList"
    ADD CONSTRAINT "purchaseList_supplierId_fkey" FOREIGN KEY ("supplierId") REFERENCES public.supplier(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: purchase purchase_medicineId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: login
--

ALTER TABLE ONLY public.purchase
    ADD CONSTRAINT "purchase_medicineId_fkey" FOREIGN KEY ("medicineId") REFERENCES public.medicine(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: purchase purchase_purchaseListId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: login
--

ALTER TABLE ONLY public.purchase
    ADD CONSTRAINT "purchase_purchaseListId_fkey" FOREIGN KEY ("purchaseListId") REFERENCES public."purchaseList"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: schedule schedule_staffId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: login
--

ALTER TABLE ONLY public.schedule
    ADD CONSTRAINT "schedule_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES public.staff(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: stock stock_medicineId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: login
--

ALTER TABLE ONLY public.stock
    ADD CONSTRAINT "stock_medicineId_fkey" FOREIGN KEY ("medicineId") REFERENCES public.medicine(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- PostgreSQL database dump complete
--

