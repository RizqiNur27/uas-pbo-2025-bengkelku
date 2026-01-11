--
-- PostgreSQL database dump
--

\restrict hpWT2oWMabO6JkP8cTcvo1nosx8WE0okbpSmtisfJZ8zsUY3zmN5iN0IqjTkaVB

-- Dumped from database version 18.1
-- Dumped by pg_dump version 18.1

-- Started on 2026-01-11 21:08:18

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 220 (class 1259 OID 41094)
-- Name: admins; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.admins (
    id integer NOT NULL,
    username character varying(50) NOT NULL,
    password character varying(255) NOT NULL,
    nama_lengkap character varying(100),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    nip character varying(50)
);


ALTER TABLE public.admins OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 41093)
-- Name: admins_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.admins_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.admins_id_seq OWNER TO postgres;

--
-- TOC entry 5090 (class 0 OID 0)
-- Dependencies: 219
-- Name: admins_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.admins_id_seq OWNED BY public.admins.id;


--
-- TOC entry 230 (class 1259 OID 65703)
-- Name: booking_details; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.booking_details (
    id integer NOT NULL,
    booking_id integer,
    service_id integer,
    harga_saat_ini numeric(15,2)
);


ALTER TABLE public.booking_details OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 65702)
-- Name: booking_details_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.booking_details_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.booking_details_id_seq OWNER TO postgres;

--
-- TOC entry 5091 (class 0 OID 0)
-- Dependencies: 229
-- Name: booking_details_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.booking_details_id_seq OWNED BY public.booking_details.id;


--
-- TOC entry 222 (class 1259 OID 57466)
-- Name: bookings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bookings (
    id integer NOT NULL,
    merek_mobil character varying(50),
    nopol character varying(20),
    km_mobil integer,
    layanan character varying(100),
    tanggal date,
    jam time without time zone,
    keluhan text,
    metode_pembayaran character varying(20),
    status character varying(20),
    total_biaya numeric(15,2) DEFAULT 0,
    tipe_reservasi character varying(50),
    created_at timestamp without time zone DEFAULT now(),
    customer_id integer NOT NULL,
    mechanic_id integer,
    whatsapp character varying(20),
    user_id integer DEFAULT 1
);


ALTER TABLE public.bookings OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 57465)
-- Name: bookings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bookings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.bookings_id_seq OWNER TO postgres;

--
-- TOC entry 5092 (class 0 OID 0)
-- Dependencies: 221
-- Name: bookings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bookings_id_seq OWNED BY public.bookings.id;


--
-- TOC entry 224 (class 1259 OID 65663)
-- Name: customers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customers (
    id integer NOT NULL,
    nama character varying(100),
    whatsapp character varying(20),
    alamat text,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.customers OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 65662)
-- Name: customers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.customers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.customers_id_seq OWNER TO postgres;

--
-- TOC entry 5093 (class 0 OID 0)
-- Dependencies: 223
-- Name: customers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.customers_id_seq OWNED BY public.customers.id;


--
-- TOC entry 226 (class 1259 OID 65674)
-- Name: mechanics; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mechanics (
    id integer NOT NULL,
    nama_mekanik character varying(100),
    status character varying(20) DEFAULT 'Available'::character varying,
    spesialisasi character varying(50)
);


ALTER TABLE public.mechanics OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 65673)
-- Name: mechanics_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.mechanics_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.mechanics_id_seq OWNER TO postgres;

--
-- TOC entry 5094 (class 0 OID 0)
-- Dependencies: 225
-- Name: mechanics_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.mechanics_id_seq OWNED BY public.mechanics.id;


--
-- TOC entry 232 (class 1259 OID 65721)
-- Name: payments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payments (
    id integer NOT NULL,
    booking_id integer,
    tgl_bayar timestamp without time zone DEFAULT now(),
    total_bayar numeric(15,2),
    metode_bayar character varying(50),
    catatan text,
    admin_id integer
);


ALTER TABLE public.payments OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 65720)
-- Name: payments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.payments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.payments_id_seq OWNER TO postgres;

--
-- TOC entry 5095 (class 0 OID 0)
-- Dependencies: 231
-- Name: payments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.payments_id_seq OWNED BY public.payments.id;


--
-- TOC entry 228 (class 1259 OID 65683)
-- Name: services; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.services (
    id integer NOT NULL,
    nama_layanan character varying(100),
    harga numeric(15,2),
    keterangan text
);


ALTER TABLE public.services OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 65682)
-- Name: services_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.services_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.services_id_seq OWNER TO postgres;

--
-- TOC entry 5096 (class 0 OID 0)
-- Dependencies: 227
-- Name: services_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.services_id_seq OWNED BY public.services.id;


--
-- TOC entry 4886 (class 2604 OID 41097)
-- Name: admins id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admins ALTER COLUMN id SET DEFAULT nextval('public.admins_id_seq'::regclass);


--
-- TOC entry 4897 (class 2604 OID 65706)
-- Name: booking_details id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.booking_details ALTER COLUMN id SET DEFAULT nextval('public.booking_details_id_seq'::regclass);


--
-- TOC entry 4888 (class 2604 OID 57469)
-- Name: bookings id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bookings ALTER COLUMN id SET DEFAULT nextval('public.bookings_id_seq'::regclass);


--
-- TOC entry 4892 (class 2604 OID 65666)
-- Name: customers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers ALTER COLUMN id SET DEFAULT nextval('public.customers_id_seq'::regclass);


--
-- TOC entry 4894 (class 2604 OID 65677)
-- Name: mechanics id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mechanics ALTER COLUMN id SET DEFAULT nextval('public.mechanics_id_seq'::regclass);


--
-- TOC entry 4898 (class 2604 OID 65724)
-- Name: payments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments ALTER COLUMN id SET DEFAULT nextval('public.payments_id_seq'::regclass);


--
-- TOC entry 4896 (class 2604 OID 65686)
-- Name: services id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.services ALTER COLUMN id SET DEFAULT nextval('public.services_id_seq'::regclass);


--
-- TOC entry 5072 (class 0 OID 41094)
-- Dependencies: 220
-- Data for Name: admins; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.admins (id, username, password, nama_lengkap, created_at, nip) FROM stdin;
1	harun	admin123	HARUN	2026-01-09 18:31:38.636851	2025009
3	harup	yaudah123	Hanif Kiting	2026-01-10 00:04:24.346095	2025009
4	omat	admin123	Muhammad Rizqi Nurrohmat	2026-01-10 16:32:17.381855	2025010
5	kasir1	123	Kasir Utama	2026-01-10 18:28:42.894524	NIP-001
6	yanti	admin123	Yanti Elnaya	2026-01-11 18:43:50.439867	2025011
\.


--
-- TOC entry 5082 (class 0 OID 65703)
-- Dependencies: 230
-- Data for Name: booking_details; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.booking_details (id, booking_id, service_id, harga_saat_ini) FROM stdin;
1	1	1	\N
2	1	2	\N
3	1	4	\N
4	1	5	\N
5	2	1	\N
6	2	4	\N
7	3	3	\N
8	3	4	\N
9	3	5	\N
10	3	6	\N
11	3	7	\N
12	3	8	\N
13	3	9	\N
14	3	10	\N
\.


--
-- TOC entry 5074 (class 0 OID 57466)
-- Dependencies: 222
-- Data for Name: bookings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.bookings (id, merek_mobil, nopol, km_mobil, layanan, tanggal, jam, keluhan, metode_pembayaran, status, total_biaya, tipe_reservasi, created_at, customer_id, mechanic_id, whatsapp, user_id) FROM stdin;
1	Civic Turbo	B 7272 VGD	\N	\N	2026-01-11	12:04:00	anskjansd	Cash	Batal	1800000.00	Offline	2026-01-11 18:46:57.743566	1	3	08972387487	6
2	Brio	A 3266 BHU	\N	\N	2026-01-11	13:05:00	akjsdjabsdkj	Cash	Selesai	600000.00	Offline	2026-01-11 18:47:46.125025	2	31	08485775847	6
3	Avanza	B 5647 UYT	\N	\N	2026-01-12	09:00:00	berisik di kaki"	Cash	Selesai	4545000.00	Online	2026-01-11 18:53:52.746278	3	11	0982328094837	1
\.


--
-- TOC entry 5076 (class 0 OID 65663)
-- Dependencies: 224
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customers (id, nama, whatsapp, alamat, created_at) FROM stdin;
1	Syahril Arif	08972387487	Cilebut	2026-01-11 18:46:15.326399
2	Yudhistira	08485775847	Bojonggede	2026-01-11 18:47:46.031189
3	Caca	0982328094837	Depok	2026-01-11 18:53:52.620039
\.


--
-- TOC entry 5078 (class 0 OID 65674)
-- Dependencies: 226
-- Data for Name: mechanics; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.mechanics (id, nama_mekanik, status, spesialisasi) FROM stdin;
2	Slamet Riyadi	Available	General Repair
5	Ujang Komarudin	Available	General Repair
6	Dedi Mulyadi	Available	General Repair
7	Andi Pratama	Available	Spesialis Mesin
8	Rizky Hidayat	Available	Spesialis Mesin
9	Eko Saputra	Available	Spesialis Mesin
10	Gunawan Wibisono	Available	Spesialis Mesin
12	Fajar Nugraha	Available	Spesialis Mesin
13	Iwan Setiawan	Available	Spesialis Oli
14	Kiki Amalia	Available	Spesialis Oli
16	Mamat Surahmat	Available	Spesialis Oli
17	Nur Cahyo	Available	Spesialis Oli
18	Oki Ardian	Available	Spesialis Oli
19	Putra Bangsa	Available	Spesialis Ban
20	Rian Saputra	Available	Spesialis Ban
21	Sandi Irawan	Available	Spesialis Ban
22	Tono Sudiro	Available	Spesialis Ban
23	Usman Harun	Available	Spesialis Ban
24	Vicky Prasetyo	Available	Spesialis Ban
25	Wahyu Hidayat	Available	Spesialis Diagnosa
26	Zainal Abidin	Available	Spesialis Diagnosa
27	Arif Budiman	Available	Spesialis Diagnosa
28	Bayu Lesmana	Available	Spesialis Diagnosa
29	Candra Wijaya	Available	Spesialis Diagnosa
30	Denny Sumargo	Available	Spesialis Diagnosa
4	Asep Sunandar	Available	General Repair
15	Lukman Hakim	Available	Spesialis Oli
1	Budi Santoso	Available	\N
3	Joko Susilo	Available	General Repair
31	Bili Gunawan	Available	Mesin
11	Hendra Wijaya	Available	Spesialis Mesin
\.


--
-- TOC entry 5084 (class 0 OID 65721)
-- Dependencies: 232
-- Data for Name: payments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payments (id, booking_id, tgl_bayar, total_bayar, metode_bayar, catatan, admin_id) FROM stdin;
1	2	2026-01-11 00:00:00	600000.00	Cash	akjsdjabsdkj	1
2	3	2026-01-11 00:00:00	4545000.00	Cash	berisik di kaki"	1
\.


--
-- TOC entry 5080 (class 0 OID 65683)
-- Dependencies: 228
-- Data for Name: services; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.services (id, nama_layanan, harga, keterangan) FROM stdin;
1	Diagnosa ECU	150000.00	Scan scanner komputer deteksi error sensor
2	Tune Up Mesin	350000.00	Servis ringan, bersih ruang bakar & throttle body
3	Overhaul Mesin	2500000.00	Servis berat, turun mesin & ganti komponen internal
4	Ganti Oli & Filter	450000.00	Termasuk Oli 10W-40 Synthetic (4L) + Filter
5	Kuras Oli Matic	850000.00	Flushing total oli transmisi ATF (8 Liter)
6	Ganti Oli Gardan	120000.00	Penggantian pelumas gear gardan
7	Ganti Ban	100000.00	Jasa bongkar pasang & balancing (per roda)
8	Spooring 3D	200000.00	Penyetelan sudut roda presisi
9	Service Rem	250000.00	Bongkar, bersih, & setel rem 4 roda
10	General Checkup	75000.00	Pengecekan kondisi umum kendaraan
\.


--
-- TOC entry 5097 (class 0 OID 0)
-- Dependencies: 219
-- Name: admins_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.admins_id_seq', 6, true);


--
-- TOC entry 5098 (class 0 OID 0)
-- Dependencies: 229
-- Name: booking_details_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.booking_details_id_seq', 14, true);


--
-- TOC entry 5099 (class 0 OID 0)
-- Dependencies: 221
-- Name: bookings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.bookings_id_seq', 3, true);


--
-- TOC entry 5100 (class 0 OID 0)
-- Dependencies: 223
-- Name: customers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.customers_id_seq', 3, true);


--
-- TOC entry 5101 (class 0 OID 0)
-- Dependencies: 225
-- Name: mechanics_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.mechanics_id_seq', 31, true);


--
-- TOC entry 5102 (class 0 OID 0)
-- Dependencies: 231
-- Name: payments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.payments_id_seq', 2, true);


--
-- TOC entry 5103 (class 0 OID 0)
-- Dependencies: 227
-- Name: services_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.services_id_seq', 11, true);


--
-- TOC entry 4901 (class 2606 OID 41103)
-- Name: admins admins_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admins
    ADD CONSTRAINT admins_pkey PRIMARY KEY (id);


--
-- TOC entry 4903 (class 2606 OID 41105)
-- Name: admins admins_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admins
    ADD CONSTRAINT admins_username_key UNIQUE (username);


--
-- TOC entry 4913 (class 2606 OID 65709)
-- Name: booking_details booking_details_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.booking_details
    ADD CONSTRAINT booking_details_pkey PRIMARY KEY (id);


--
-- TOC entry 4905 (class 2606 OID 57475)
-- Name: bookings bookings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_pkey PRIMARY KEY (id);


--
-- TOC entry 4907 (class 2606 OID 65672)
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (id);


--
-- TOC entry 4909 (class 2606 OID 65681)
-- Name: mechanics mechanics_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mechanics
    ADD CONSTRAINT mechanics_pkey PRIMARY KEY (id);


--
-- TOC entry 4915 (class 2606 OID 65732)
-- Name: payments payments_booking_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_booking_id_key UNIQUE (booking_id);


--
-- TOC entry 4917 (class 2606 OID 65730)
-- Name: payments payments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (id);


--
-- TOC entry 4911 (class 2606 OID 65691)
-- Name: services services_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.services
    ADD CONSTRAINT services_pkey PRIMARY KEY (id);


--
-- TOC entry 4920 (class 2606 OID 65710)
-- Name: booking_details booking_details_booking_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.booking_details
    ADD CONSTRAINT booking_details_booking_id_fkey FOREIGN KEY (booking_id) REFERENCES public.bookings(id);


--
-- TOC entry 4921 (class 2606 OID 65715)
-- Name: booking_details booking_details_service_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.booking_details
    ADD CONSTRAINT booking_details_service_id_fkey FOREIGN KEY (service_id) REFERENCES public.services(id);


--
-- TOC entry 4918 (class 2606 OID 65692)
-- Name: bookings fk_booking_customer; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT fk_booking_customer FOREIGN KEY (customer_id) REFERENCES public.customers(id);


--
-- TOC entry 4919 (class 2606 OID 65697)
-- Name: bookings fk_booking_mechanic; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT fk_booking_mechanic FOREIGN KEY (mechanic_id) REFERENCES public.mechanics(id);


--
-- TOC entry 4922 (class 2606 OID 66248)
-- Name: payments fk_payment_admin; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT fk_payment_admin FOREIGN KEY (admin_id) REFERENCES public.admins(id);


--
-- TOC entry 4923 (class 2606 OID 65733)
-- Name: payments payments_booking_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_booking_id_fkey FOREIGN KEY (booking_id) REFERENCES public.bookings(id);


-- Completed on 2026-01-11 21:08:20

--
-- PostgreSQL database dump complete
--

\unrestrict hpWT2oWMabO6JkP8cTcvo1nosx8WE0okbpSmtisfJZ8zsUY3zmN5iN0IqjTkaVB

