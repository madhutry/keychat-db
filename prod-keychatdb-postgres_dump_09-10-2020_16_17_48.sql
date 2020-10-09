--
-- PostgreSQL database cluster dump
--

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Roles
--

CREATE ROLE keychatusr1;
ALTER ROLE keychatusr1 WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'md54f2ed80b4dabdcdf42449f7169a571c6';
CREATE ROLE postgres;
ALTER ROLE postgres WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'md5a70b3fb50b83ebe6ddf812802ef9ce4e';


--
-- Role memberships
--

GRANT postgres TO keychatusr1;




--
-- Databases
--

--
-- Database "template1" dump
--

\connect template1

--
-- PostgreSQL database dump
--

-- Dumped from database version 13.0 (Debian 13.0-1.pgdg100+1)
-- Dumped by pg_dump version 13.0 (Debian 13.0-1.pgdg100+1)

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

--
-- PostgreSQL database dump complete
--

--
-- Database "keychatdb" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 13.0 (Debian 13.0-1.pgdg100+1)
-- Dumped by pg_dump version 13.0 (Debian 13.0-1.pgdg100+1)

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

--
-- Name: keychatdb; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE keychatdb WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.utf8';


ALTER DATABASE keychatdb OWNER TO postgres;

\connect keychatdb

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

--
-- Name: f_truncate_tables(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_truncate_tables(_username text) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
   RAISE NOTICE '%', 
   -- EXECUTE  -- dangerous, test before you execute!
  (SELECT 'TRUNCATE TABLE '
       || string_agg(format('%I.%I', schemaname, tablename), ', ')
       || ' CASCADE'
   FROM   pg_tables
   WHERE  tableowner = _username
   AND    schemaname = 'public'
   );
END
$$;


ALTER FUNCTION public.f_truncate_tables(_username text) OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: access_code_map; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.access_code_map (
    id integer NOT NULL,
    registration_id text,
    matrix_access_code text,
    frieze_access_code text,
    insert_dt timestamp with time zone,
    updated_dt timestamp with time zone,
    active integer DEFAULT 1,
    domain_name text
);


ALTER TABLE public.access_code_map OWNER TO postgres;

--
-- Name: access_code_map_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.access_code_map_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.access_code_map_id_seq OWNER TO postgres;

--
-- Name: access_code_map_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.access_code_map_id_seq OWNED BY public.access_code_map.id;


--
-- Name: admin_info_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.admin_info_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public.admin_info_id_seq OWNER TO postgres;

--
-- Name: admin_info; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.admin_info (
    id integer DEFAULT nextval('public.admin_info_id_seq'::regclass),
    userid text,
    access_code text,
    active "char" DEFAULT 'Y'::"char",
    filter_id integer
);


ALTER TABLE public.admin_info OWNER TO postgres;

--
-- Name: agents_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.agents_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.agents_id_seq OWNER TO postgres;

--
-- Name: agents; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.agents (
    id integer DEFAULT nextval('public.agents_id_seq'::regclass) NOT NULL,
    userid text,
    display_name text,
    main_owner_id integer,
    create_ts timestamp without time zone,
    matrix_access_code text,
    avatar_img_url text
);


ALTER TABLE public.agents OWNER TO postgres;

--
-- Name: cardmessage_resp_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cardmessage_resp_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public.cardmessage_resp_seq OWNER TO postgres;

--
-- Name: cardmessage_response; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cardmessage_response (
    active text,
    mesg_id text,
    response text,
    event_id text,
    id integer DEFAULT nextval('public.cardmessage_resp_seq'::regclass)
);


ALTER TABLE public.cardmessage_response OWNER TO postgres;

--
-- Name: chat_registration; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.chat_registration (
    id text,
    prev_batch_id text,
    user_id text,
    room_id text,
    full_name text,
    mobile text,
    create_dt timestamp with time zone,
    update_dt timestamp with time zone,
    room_alias text,
    info json
);


ALTER TABLE public.chat_registration OWNER TO postgres;

--
-- Name: cust_upload_details_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cust_upload_details_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cust_upload_details_id_seq OWNER TO postgres;

--
-- Name: cust_upload_details; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cust_upload_details (
    id integer DEFAULT nextval('public.cust_upload_details_id_seq'::regclass) NOT NULL,
    batchid text,
    info json,
    create_ts timestamp without time zone
);


ALTER TABLE public.cust_upload_details OWNER TO postgres;

--
-- Name: data_launch; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.data_launch (
    id text,
    launch_id text,
    dataid text,
    data text,
    active bigint DEFAULT '1'::bigint,
    deleterec numeric DEFAULT '1'::numeric
);


ALTER TABLE public.data_launch OWNER TO postgres;

--
-- Name: data_new; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.data_new (
    id text,
    editid text,
    dataid text,
    data text,
    active bigint DEFAULT '1'::bigint,
    deleterec numeric DEFAULT '1'::numeric
);


ALTER TABLE public.data_new OWNER TO postgres;

--
-- Name: design_master; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.design_master (
    id text,
    generic_id text,
    launch_id text,
    base_template_id text,
    templatename text,
    userid text
);


ALTER TABLE public.design_master OWNER TO postgres;

--
-- Name: feedback_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.feedback_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.feedback_id_seq OWNER TO postgres;

--
-- Name: feedback; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.feedback (
    id integer DEFAULT nextval('public.feedback_id_seq'::regclass) NOT NULL,
    domainname text,
    feedback json,
    ip_addr text,
    create_ts timestamp without time zone DEFAULT now()
);


ALTER TABLE public.feedback OWNER TO postgres;

--
-- Name: image_upload_cloudinary; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.image_upload_cloudinary (
    id integer NOT NULL,
    matrixid text,
    response json
);


ALTER TABLE public.image_upload_cloudinary OWNER TO postgres;

--
-- Name: image_upload_cloudinary_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.image_upload_cloudinary_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.image_upload_cloudinary_id_seq OWNER TO postgres;

--
-- Name: image_upload_cloudinary_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.image_upload_cloudinary_id_seq OWNED BY public.image_upload_cloudinary.id;


--
-- Name: images; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.images (
    id integer NOT NULL,
    designid text NOT NULL,
    info json NOT NULL,
    batchid text,
    create_ts timestamp without time zone,
    userid text,
    avatar_img_url text,
    display_name text
);


ALTER TABLE public.images OWNER TO postgres;

--
-- Name: images_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.images_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.images_id_seq OWNER TO postgres;

--
-- Name: images_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.images_id_seq OWNED BY public.images.id;


--
-- Name: launch_master; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.launch_master (
    id text,
    domain_name text,
    design_id text,
    active text
);


ALTER TABLE public.launch_master OWNER TO postgres;

--
-- Name: mat_acc_cd_owner; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mat_acc_cd_owner (
    id integer NOT NULL,
    domain_name text,
    matrix_access_code text,
    userid text,
    avatar_img_url text DEFAULT 'http://google.com'::text,
    display_name text,
    email_id text,
    last_mesg_recd_time text
);


ALTER TABLE public.mat_acc_cd_owner OWNER TO postgres;

--
-- Name: mat_acc_cd_owner_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.mat_acc_cd_owner_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.mat_acc_cd_owner_id_seq OWNER TO postgres;

--
-- Name: mat_acc_cd_owner_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.mat_acc_cd_owner_id_seq OWNED BY public.mat_acc_cd_owner.id;


--
-- Name: mat_acc_cd_owner_id_seq1; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.mat_acc_cd_owner ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.mat_acc_cd_owner_id_seq1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: messages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.messages (
    id integer NOT NULL,
    mesg_id text NOT NULL,
    sender text,
    room_id text,
    message text NOT NULL,
    customer_read integer DEFAULT 0,
    customer_read_ts timestamp with time zone,
    owner_read integer DEFAULT 0,
    owner_read_ts timestamp with time zone,
    server_received_ts text,
    create_ts timestamp with time zone,
    ack_time timestamp with time zone,
    url text,
    mesg_type text,
    event_id text
);


ALTER TABLE public.messages OWNER TO postgres;

--
-- Name: messages_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.messages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.messages_id_seq OWNER TO postgres;

--
-- Name: messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.messages_id_seq OWNED BY public.messages.id;


--
-- Name: notification_job; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notification_job (
    id integer NOT NULL,
    start_time timestamp with time zone,
    end_time timestamp with time zone,
    payload json,
    batch_id text,
    processed integer
);


ALTER TABLE public.notification_job OWNER TO postgres;

--
-- Name: notification_job_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.notification_job_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.notification_job_id_seq OWNER TO postgres;

--
-- Name: notification_job_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.notification_job_id_seq OWNED BY public.notification_job.id;


--
-- Name: portno; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.portno (
    portno bigint DEFAULT '4000'::bigint,
    env text
);


ALTER TABLE public.portno OWNER TO postgres;

--
-- Name: register; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.register (
    fname text,
    lname text,
    domainname text,
    emailid text,
    verified numeric,
    otp bigint,
    password text,
    create_dt timestamp without time zone DEFAULT now(),
    ip_addr text
);


ALTER TABLE public.register OWNER TO postgres;

--
-- Name: register_services; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.register_services (
    domainname text NOT NULL,
    chorus text,
    elist text,
    kdb text,
    launched bigint,
    template text,
    progress bigint DEFAULT '0'::bigint,
    fileid text,
    templatename text,
    launched_bool boolean
);


ALTER TABLE public.register_services OWNER TO postgres;

--
-- Name: s3_upload; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.s3_upload (
    id integer NOT NULL,
    etag text,
    url text,
    create_ts timestamp without time zone DEFAULT now(),
    matrix_content_id text
);


ALTER TABLE public.s3_upload OWNER TO postgres;

--
-- Name: s3_upload_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.s3_upload_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.s3_upload_id_seq OWNER TO postgres;

--
-- Name: s3_upload_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.s3_upload_id_seq OWNED BY public.s3_upload.id;


--
-- Name: servers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.servers (
    name text,
    portno bigint,
    userid text,
    templatedomainproxy integer,
    dir text,
    active bigint DEFAULT '1'::bigint,
    noserver bigint DEFAULT '0'::bigint,
    env text,
    fileid text
);


ALTER TABLE public.servers OWNER TO postgres;

--
-- Name: ss_images; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ss_images (
    id integer NOT NULL,
    designid text NOT NULL,
    info json NOT NULL,
    imgid text NOT NULL,
    width numeric NOT NULL,
    height numeric NOT NULL,
    del numeric DEFAULT 0
);


ALTER TABLE public.ss_images OWNER TO postgres;

--
-- Name: ss_images_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ss_images_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ss_images_id_seq OWNER TO postgres;

--
-- Name: ss_images_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ss_images_id_seq OWNED BY public.ss_images.id;


--
-- Name: template_properties; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.template_properties (
    key text,
    value text
);


ALTER TABLE public.template_properties OWNER TO postgres;

--
-- Name: templates; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.templates (
    id text,
    name text,
    image_url_main text,
    image_url_desktop text,
    image_url_mobile text,
    image_url_tab text,
    active integer
);


ALTER TABLE public.templates OWNER TO postgres;

--
-- Name: access_code_map id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.access_code_map ALTER COLUMN id SET DEFAULT nextval('public.access_code_map_id_seq'::regclass);


--
-- Name: image_upload_cloudinary id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.image_upload_cloudinary ALTER COLUMN id SET DEFAULT nextval('public.image_upload_cloudinary_id_seq'::regclass);


--
-- Name: images id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.images ALTER COLUMN id SET DEFAULT nextval('public.images_id_seq'::regclass);


--
-- Name: messages id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages ALTER COLUMN id SET DEFAULT nextval('public.messages_id_seq'::regclass);


--
-- Name: notification_job id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notification_job ALTER COLUMN id SET DEFAULT nextval('public.notification_job_id_seq'::regclass);


--
-- Name: s3_upload id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.s3_upload ALTER COLUMN id SET DEFAULT nextval('public.s3_upload_id_seq'::regclass);


--
-- Name: ss_images id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ss_images ALTER COLUMN id SET DEFAULT nextval('public.ss_images_id_seq'::regclass);


--
-- Name: access_code_map access_code_map_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.access_code_map
    ADD CONSTRAINT access_code_map_pkey PRIMARY KEY (id);


--
-- Name: register_services idx_25033_sqlite_autoindex_register_services_1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.register_services
    ADD CONSTRAINT idx_25033_sqlite_autoindex_register_services_1 PRIMARY KEY (domainname);


--
-- Name: images images_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.images
    ADD CONSTRAINT images_pkey PRIMARY KEY (id);


--
-- Name: mat_acc_cd_owner mat_acc_cd_owner_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mat_acc_cd_owner
    ADD CONSTRAINT mat_acc_cd_owner_pkey PRIMARY KEY (id);


--
-- Name: ss_images ss_images_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ss_images
    ADD CONSTRAINT ss_images_pkey PRIMARY KEY (id);


--
-- Name: idx_25074_sqlite_autoindex_servers_1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_25074_sqlite_autoindex_servers_1 ON public.servers USING btree (name, portno, userid, env);


--
-- Name: idx_25082_sqlite_autoindex_templates_1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_25082_sqlite_autoindex_templates_1 ON public.templates USING btree (name);


--
-- Name: DATABASE keychatdb; Type: ACL; Schema: -; Owner: postgres
--

GRANT ALL ON DATABASE keychatdb TO keychatusr1;


--
-- PostgreSQL database dump complete
--

--
-- Database "postgres" dump
--

\connect postgres

--
-- PostgreSQL database dump
--

-- Dumped from database version 13.0 (Debian 13.0-1.pgdg100+1)
-- Dumped by pg_dump version 13.0 (Debian 13.0-1.pgdg100+1)

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

--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database cluster dump complete
--

