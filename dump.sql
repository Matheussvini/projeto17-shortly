--
-- PostgreSQL database dump
--

-- Dumped from database version 14.5 (Ubuntu 14.5-0ubuntu0.22.04.1)
-- Dumped by pg_dump version 14.5 (Ubuntu 14.5-0ubuntu0.22.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
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
-- Name: urls; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.urls (
    id integer NOT NULL,
    url text NOT NULL,
    "shortUrl" text,
    user_id integer NOT NULL,
    visits integer DEFAULT 0 NOT NULL,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: urls_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.urls_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: urls_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.urls_id_seq OWNED BY public.urls.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id integer NOT NULL,
    name character varying(60) NOT NULL,
    email text NOT NULL,
    password text NOT NULL
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: urls id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.urls ALTER COLUMN id SET DEFAULT nextval('public.urls_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: urls; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.urls VALUES (3, 'https://www.web.whatsapp.com', 'RlwqtWCr81', 5, 0, '2022-12-23 15:20:32.099408');
INSERT INTO public.urls VALUES (1, 'https://www.web.whatsapp.com', 'UIFtsUj_WG', 5, 6, '2022-12-23 15:20:28.547518');
INSERT INTO public.urls VALUES (2, 'https://www.web.whatsapp.com', 'nzy91Dds37', 5, 3, '2022-12-23 15:20:29.378649');
INSERT INTO public.urls VALUES (4, 'https://www.web.whatsapp.com', 'CD_ZLYrxPn', 5, 1, '2022-12-23 15:20:33.93919');
INSERT INTO public.urls VALUES (6, 'https://www.web.whatsapp.com', 'hAgCY-qWFJ', 4, 0, '2022-12-23 15:36:04.37755');
INSERT INTO public.urls VALUES (8, 'https://www.web.whatsapp.com2', 'wU8osxjGb2', 4, 0, '2022-12-23 15:36:13.742315');
INSERT INTO public.urls VALUES (9, 'https://www.web.whatsapp.com10', '9jF4vkClxX', 4, 0, '2022-12-23 15:36:16.81205');
INSERT INTO public.urls VALUES (7, 'https://www.web.whatsapp.com', 'iwPPflvj6m', 4, 10, '2022-12-23 15:36:10.411985');
INSERT INTO public.urls VALUES (10, 'https://www.web.whatsapp.com10', 'yBWoirbilC', 4, 4, '2022-12-23 15:36:17.064514');
INSERT INTO public.urls VALUES (11, 'https://www.web.whatsapp.com10', 'n30dWA5lYx', 4, 2, '2022-12-23 15:36:17.308512');
INSERT INTO public.urls VALUES (5, 'https://www.web.whatsapp.com', 'uO6YeOXaxD', 4, 1, '2022-12-23 15:36:03.499329');
INSERT INTO public.urls VALUES (13, 'https://outlook.com', '29HtZnsgeX', 6, 0, '2022-12-23 16:01:45.250944');
INSERT INTO public.urls VALUES (14, 'https://outlook.com', 'Cu1Mn2z1po', 6, 2, '2022-12-23 16:02:09.447765');


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.users VALUES (1, 'João', 'joçao@gmail.com', '12345');
INSERT INTO public.users VALUES (3, 'matheus', 'mat@gmail.com', '123456');
INSERT INTO public.users VALUES (4, 'Matheus', 'matt@gmail.com', '$2b$10$VekSu2hZwPpcHfycoIL9q.prgDfEERRZxLjRnF/BL21kqvsB9RZDu');
INSERT INTO public.users VALUES (5, 'Matheus', 'math@gmail.com', '$2b$10$disDea6ZW5RazIpaCdIh1u7iiXsp16klJ9o/149Wg0D.8Qt6VH.sS');
INSERT INTO public.users VALUES (6, 'João', 'joao@driven.com.br', '$2b$10$mkQUeOI3oE.4G8NsMHCRge0R6p8v/nBOLXmDvR2de/s0sSx8XLs/i');


--
-- Name: urls_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.urls_id_seq', 14, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.users_id_seq', 6, true);


--
-- Name: urls urls_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.urls
    ADD CONSTRAINT urls_pkey PRIMARY KEY (id);


--
-- Name: urls urls_shortUrl_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.urls
    ADD CONSTRAINT "urls_shortUrl_key" UNIQUE ("shortUrl");


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: urls urls_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.urls
    ADD CONSTRAINT urls_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

