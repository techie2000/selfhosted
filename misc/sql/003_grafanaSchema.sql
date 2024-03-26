-- dumped from grafana 10.4.1

BEGIN;





--
-- PostgreSQL database dump
--

-- Dumped from database version 15.6 (Debian 15.6-1.pgdg120+2)
-- Dumped by pg_dump version 15.6 (Debian 15.6-1.pgdg120+2)

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
-- Name: alert; Type: TABLE; Schema: public; Owner: grafana
--

CREATE TABLE public.alert
(
    id              integer                     NOT NULL,
    version         bigint                      NOT NULL,
    dashboard_id    bigint                      NOT NULL,
    panel_id        bigint                      NOT NULL,
    org_id          bigint                      NOT NULL,
    name            character varying(255)      NOT NULL,
    message         text                        NOT NULL,
    state           character varying(190)      NOT NULL,
    settings        text                        NOT NULL,
    frequency       bigint                      NOT NULL,
    handler         bigint                      NOT NULL,
    severity        text                        NOT NULL,
    silenced        boolean                     NOT NULL,
    execution_error text                        NOT NULL,
    eval_data       text,
    eval_date       timestamp without time zone,
    new_state_date  timestamp without time zone NOT NULL,
    state_changes   integer                     NOT NULL,
    created         timestamp without time zone NOT NULL,
    updated         timestamp without time zone NOT NULL,
    "for"           bigint
);


ALTER TABLE public.alert
    OWNER TO grafana;

--
-- Name: alert_configuration; Type: TABLE; Schema: public; Owner: grafana
--

CREATE TABLE public.alert_configuration
(
    id                         integer                                                               NOT NULL,
    alertmanager_configuration text                                                                  NOT NULL,
    configuration_version      character varying(3)                                                  NOT NULL,
    created_at                 integer                                                               NOT NULL,
    "default"                  boolean               DEFAULT false                                   NOT NULL,
    org_id                     bigint                DEFAULT 0                                       NOT NULL,
    configuration_hash         character varying(32) DEFAULT 'not-yet-calculated'::character varying NOT NULL
);


ALTER TABLE public.alert_configuration
    OWNER TO grafana;

--
-- Name: alert_configuration_history; Type: TABLE; Schema: public; Owner: grafana
--

CREATE TABLE public.alert_configuration_history
(
    id                         integer                                                               NOT NULL,
    org_id                     bigint                DEFAULT 0                                       NOT NULL,
    alertmanager_configuration text                                                                  NOT NULL,
    configuration_hash         character varying(32) DEFAULT 'not-yet-calculated'::character varying NOT NULL,
    configuration_version      character varying(3)                                                  NOT NULL,
    created_at                 integer                                                               NOT NULL,
    "default"                  boolean               DEFAULT false                                   NOT NULL,
    last_applied               integer               DEFAULT 0                                       NOT NULL
);


ALTER TABLE public.alert_configuration_history
    OWNER TO grafana;

--
-- Name: alert_configuration_history_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana
--

-- CREATE SEQUENCE public.alert_configuration_history_id_seq
--     AS integer
--     START WITH 1
--     INCREMENT BY 1
--     NO MINVALUE
--     NO MAXVALUE
--     CACHE 1
--           ;
CREATE SEQUENCE IF NOT EXISTS public.alert_configuration_history_id_seq
START 1
    INCREMENT 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
    AS integer
;


ALTER TABLE public.alert_configuration_history_id_seq
    OWNER TO grafana;

--
-- Name: alert_configuration_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana
--

ALTER SEQUENCE public.alert_configuration_history_id_seq OWNED BY public.alert_configuration_history.id;


--
-- Name: alert_configuration_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana
--


CREATE SEQUENCE IF NOT EXISTS public.alert_configuration_id_seq AS integer
START
1
    INCREMENT 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.alert_configuration_id_seq
    OWNER TO grafana;

--
-- Name: alert_configuration_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana
--

ALTER SEQUENCE public.alert_configuration_id_seq OWNED BY public.alert_configuration.id;


--
-- Name: alert_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana
--

CREATE SEQUENCE public.alert_id_seq AS integer
START 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.alert_id_seq
    OWNER TO grafana;

--
-- Name: alert_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana
--

ALTER SEQUENCE public.alert_id_seq OWNED BY public.alert.id;


--
-- Name: alert_image; Type: TABLE; Schema: public; Owner: grafana
--

CREATE TABLE public.alert_image
(
    id         integer                     NOT NULL,
    token      character varying(190)      NOT NULL,
    path       character varying(190)      NOT NULL,
    url        character varying(2048)     NOT NULL,
    created_at timestamp without time zone NOT NULL,
    expires_at timestamp without time zone NOT NULL
);


ALTER TABLE public.alert_image
    OWNER TO grafana;

--
-- Name: alert_image_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana
--

CREATE SEQUENCE public.alert_image_id_seq AS integer
START
1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.alert_image_id_seq
    OWNER TO grafana;

--
-- Name: alert_image_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana
--

ALTER SEQUENCE public.alert_image_id_seq OWNED BY public.alert_image.id;


--
-- Name: alert_instance; Type: TABLE; Schema: public; Owner: grafana
--

CREATE TABLE public.alert_instance
(
    rule_org_id         bigint                          NOT NULL,
    rule_uid            character varying(40) DEFAULT 0 NOT NULL,
    labels              text                            NOT NULL,
    labels_hash         character varying(190)          NOT NULL,
    current_state       character varying(190)          NOT NULL,
    current_state_since bigint                          NOT NULL,
    last_eval_time      bigint                          NOT NULL,
    current_state_end   bigint                DEFAULT 0 NOT NULL,
    current_reason      character varying(190),
    result_fingerprint  character varying(16)
);


ALTER TABLE public.alert_instance
    OWNER TO grafana;

--
-- Name: alert_notification; Type: TABLE; Schema: public; Owner: grafana
--

CREATE TABLE public.alert_notification
(
    id                      integer                     NOT NULL,
    org_id                  bigint                      NOT NULL,
    name                    character varying(190)      NOT NULL,
    type                    character varying(255)      NOT NULL,
    settings                text                        NOT NULL,
    created                 timestamp without time zone NOT NULL,
    updated                 timestamp without time zone NOT NULL,
    is_default              boolean DEFAULT false       NOT NULL,
    frequency               bigint,
    send_reminder           boolean DEFAULT false,
    disable_resolve_message boolean DEFAULT false       NOT NULL,
    uid                     character varying(40),
    secure_settings         text
);


ALTER TABLE public.alert_notification
    OWNER TO grafana;

--
-- Name: alert_notification_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana
--

CREATE SEQUENCE public.alert_notification_id_seq AS integer
START
1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.alert_notification_id_seq
    OWNER TO grafana;

--
-- Name: alert_notification_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana
--

ALTER SEQUENCE public.alert_notification_id_seq OWNED BY public.alert_notification.id;


--
-- Name: alert_notification_state; Type: TABLE; Schema: public; Owner: grafana
--

CREATE TABLE public.alert_notification_state
(
    id                               integer               NOT NULL,
    org_id                           bigint                NOT NULL,
    alert_id                         bigint                NOT NULL,
    notifier_id                      bigint                NOT NULL,
    state                            character varying(50) NOT NULL,
    version                          bigint                NOT NULL,
    updated_at                       bigint                NOT NULL,
    alert_rule_state_updated_version bigint                NOT NULL
);


ALTER TABLE public.alert_notification_state
    OWNER TO grafana;

--
-- Name: alert_notification_state_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana
--

CREATE SEQUENCE public.alert_notification_state_id_seq AS integer
START
1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.alert_notification_state_id_seq
    OWNER TO grafana;

--
-- Name: alert_notification_state_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana
--

ALTER SEQUENCE public.alert_notification_state_id_seq OWNED BY public.alert_notification_state.id;


--
-- Name: alert_rule; Type: TABLE; Schema: public; Owner: grafana
--

CREATE TABLE public.alert_rule
(
    id                    integer                                                     NOT NULL,
    org_id                bigint                                                      NOT NULL,
    title                 character varying(190)                                      NOT NULL,
    condition             character varying(190)                                      NOT NULL,
    data                  text                                                        NOT NULL,
    updated               timestamp without time zone                                 NOT NULL,
    interval_seconds      bigint                DEFAULT 60                            NOT NULL,
    version               integer               DEFAULT 0                             NOT NULL,
    uid                   character varying(40) DEFAULT 0                             NOT NULL,
    namespace_uid         character varying(40)                                       NOT NULL,
    rule_group            character varying(190)                                      NOT NULL,
    no_data_state         character varying(15) DEFAULT 'NoData'::character varying   NOT NULL,
    exec_err_state        character varying(15) DEFAULT 'Alerting'::character varying NOT NULL,
    "for"                 bigint                DEFAULT 0                             NOT NULL,
    annotations           text,
    labels                text,
    dashboard_uid         character varying(40),
    panel_id              bigint,
    rule_group_idx        integer               DEFAULT 1                             NOT NULL,
    is_paused             boolean               DEFAULT false                         NOT NULL,
    notification_settings text
);


ALTER TABLE public.alert_rule
    OWNER TO grafana;

--
-- Name: alert_rule_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana
--

CREATE SEQUENCE public.alert_rule_id_seq AS integer
START
1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.alert_rule_id_seq
    OWNER TO grafana;

--
-- Name: alert_rule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana
--

ALTER SEQUENCE public.alert_rule_id_seq OWNED BY public.alert_rule.id;


--
-- Name: alert_rule_tag; Type: TABLE; Schema: public; Owner: grafana
--

CREATE TABLE public.alert_rule_tag
(
    id       integer NOT NULL,
    alert_id bigint  NOT NULL,
    tag_id   bigint  NOT NULL
);


ALTER TABLE public.alert_rule_tag
    OWNER TO grafana;

--
-- Name: alert_rule_tag_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana
--

CREATE SEQUENCE public.alert_rule_tag_id_seq AS integer
START
1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.alert_rule_tag_id_seq
    OWNER TO grafana;

--
-- Name: alert_rule_tag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana
--

ALTER SEQUENCE public.alert_rule_tag_id_seq OWNED BY public.alert_rule_tag.id;


--
-- Name: alert_rule_version; Type: TABLE; Schema: public; Owner: grafana
--

CREATE TABLE public.alert_rule_version
(
    id                    integer                                                     NOT NULL,
    rule_org_id           bigint                                                      NOT NULL,
    rule_uid              character varying(40) DEFAULT 0                             NOT NULL,
    rule_namespace_uid    character varying(40)                                       NOT NULL,
    rule_group            character varying(190)                                      NOT NULL,
    parent_version        integer                                                     NOT NULL,
    restored_from         integer                                                     NOT NULL,
    version               integer                                                     NOT NULL,
    created               timestamp without time zone                                 NOT NULL,
    title                 character varying(190)                                      NOT NULL,
    condition             character varying(190)                                      NOT NULL,
    data                  text                                                        NOT NULL,
    interval_seconds      bigint                                                      NOT NULL,
    no_data_state         character varying(15) DEFAULT 'NoData'::character varying   NOT NULL,
    exec_err_state        character varying(15) DEFAULT 'Alerting'::character varying NOT NULL,
    "for"                 bigint                DEFAULT 0                             NOT NULL,
    annotations           text,
    labels                text,
    rule_group_idx        integer               DEFAULT 1                             NOT NULL,
    is_paused             boolean               DEFAULT false                         NOT NULL,
    notification_settings text
);


ALTER TABLE public.alert_rule_version
    OWNER TO grafana;

--
-- Name: alert_rule_version_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana
--

CREATE SEQUENCE public.alert_rule_version_id_seq AS integer
START
1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.alert_rule_version_id_seq
    OWNER TO grafana;

--
-- Name: alert_rule_version_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana
--

ALTER SEQUENCE public.alert_rule_version_id_seq OWNED BY public.alert_rule_version.id;


--
-- Name: annotation; Type: TABLE; Schema: public; Owner: grafana
--

CREATE TABLE public.annotation
(
    id           integer               NOT NULL,
    org_id       bigint                NOT NULL,
    alert_id     bigint,
    user_id      bigint,
    dashboard_id bigint,
    panel_id     bigint,
    category_id  bigint,
    type         character varying(25) NOT NULL,
    title        text                  NOT NULL,
    text         text                  NOT NULL,
    metric       character varying(255),
    prev_state   character varying(25) NOT NULL,
    new_state    character varying(25) NOT NULL,
    data         text                  NOT NULL,
    epoch        bigint                NOT NULL,
    region_id    bigint DEFAULT 0,
    tags         character varying(4096),
    created      bigint DEFAULT 0,
    updated      bigint DEFAULT 0,
    epoch_end    bigint DEFAULT 0      NOT NULL
);


ALTER TABLE public.annotation
    OWNER TO grafana;

--
-- Name: annotation_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana
--

CREATE SEQUENCE public.annotation_id_seq AS integer
START
1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.annotation_id_seq
    OWNER TO grafana;

--
-- Name: annotation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana
--

ALTER SEQUENCE public.annotation_id_seq OWNED BY public.annotation.id;


--
-- Name: annotation_tag; Type: TABLE; Schema: public; Owner: grafana
--

CREATE TABLE public.annotation_tag
(
    id            integer NOT NULL,
    annotation_id bigint  NOT NULL,
    tag_id        bigint  NOT NULL
);


ALTER TABLE public.annotation_tag
    OWNER TO grafana;

--
-- Name: annotation_tag_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana
--

CREATE SEQUENCE public.annotation_tag_id_seq AS integer
START
1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.annotation_tag_id_seq
    OWNER TO grafana;

--
-- Name: annotation_tag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana
--

ALTER SEQUENCE public.annotation_tag_id_seq OWNED BY public.annotation_tag.id;


--
-- Name: anon_device; Type: TABLE; Schema: public; Owner: grafana
--

CREATE TABLE public.anon_device
(
    id         integer                     NOT NULL,
    client_ip  character varying(255)      NOT NULL,
    created_at timestamp without time zone NOT NULL,
    device_id  character varying(127)      NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    user_agent character varying(255)      NOT NULL
);


ALTER TABLE public.anon_device
    OWNER TO grafana;

--
-- Name: anon_device_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana
--

CREATE SEQUENCE public.anon_device_id_seq AS integer
START
1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.anon_device_id_seq
    OWNER TO grafana;

--
-- Name: anon_device_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana
--

ALTER SEQUENCE public.anon_device_id_seq OWNED BY public.anon_device.id;


--
-- Name: api_key; Type: TABLE; Schema: public; Owner: grafana
--

CREATE TABLE public.api_key
(
    id                 integer                     NOT NULL,
    org_id             bigint                      NOT NULL,
    name               character varying(190)      NOT NULL,
    key                character varying(190)      NOT NULL,
    role               character varying(255)      NOT NULL,
    created            timestamp without time zone NOT NULL,
    updated            timestamp without time zone NOT NULL,
    expires            bigint,
    service_account_id bigint,
    last_used_at       timestamp without time zone,
    is_revoked         boolean DEFAULT false
);


ALTER TABLE public.api_key
    OWNER TO grafana;

--
-- Name: api_key_id_seq1; Type: SEQUENCE; Schema: public; Owner: grafana
--

CREATE SEQUENCE public.api_key_id_seq1 AS integer
START
1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_key_id_seq1
    OWNER TO grafana;

--
-- Name: api_key_id_seq1; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana
--

ALTER SEQUENCE public.api_key_id_seq1 OWNED BY public.api_key.id;


--
-- Name: builtin_role; Type: TABLE; Schema: public; Owner: grafana
--

CREATE TABLE public.builtin_role
(
    id      integer                     NOT NULL,
    role    character varying(190)      NOT NULL,
    role_id bigint                      NOT NULL,
    created timestamp without time zone NOT NULL,
    updated timestamp without time zone NOT NULL,
    org_id  bigint DEFAULT 0            NOT NULL
);


ALTER TABLE public.builtin_role
    OWNER TO grafana;

--
-- Name: builtin_role_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana
--

CREATE SEQUENCE public.builtin_role_id_seq AS integer
START
1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.builtin_role_id_seq
    OWNER TO grafana;

--
-- Name: builtin_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana
--

ALTER SEQUENCE public.builtin_role_id_seq OWNED BY public.builtin_role.id;


--
-- Name: cache_data; Type: TABLE; Schema: public; Owner: grafana
--

CREATE TABLE public.cache_data
(
    cache_key  character varying(168) NOT NULL,
    data       bytea                  NOT NULL,
    expires    integer                NOT NULL,
    created_at integer                NOT NULL
);


ALTER TABLE public.cache_data
    OWNER TO grafana;

--
-- Name: correlation; Type: TABLE; Schema: public; Owner: grafana
--

CREATE TABLE public.correlation
(
    uid         character varying(40) NOT NULL,
    org_id      bigint  DEFAULT 0     NOT NULL,
    source_uid  character varying(40) NOT NULL,
    target_uid  character varying(40),
    label       text                  NOT NULL,
    description text                  NOT NULL,
    config      text,
    provisioned boolean DEFAULT false NOT NULL
);


ALTER TABLE public.correlation
    OWNER TO grafana;

--
-- Name: dashboard; Type: TABLE; Schema: public; Owner: grafana
--

CREATE TABLE public.dashboard
(
    id         integer                     NOT NULL,
    version    integer                     NOT NULL,
    slug       character varying(189)      NOT NULL,
    title      character varying(189)      NOT NULL,
    data       text                        NOT NULL,
    org_id     bigint                      NOT NULL,
    created    timestamp without time zone NOT NULL,
    updated    timestamp without time zone NOT NULL,
    updated_by integer,
    created_by integer,
    gnet_id    bigint,
    plugin_id  character varying(189),
    folder_id  bigint  DEFAULT 0           NOT NULL,
    is_folder  boolean DEFAULT false       NOT NULL,
    has_acl    boolean DEFAULT false       NOT NULL,
    uid        character varying(40),
    is_public  boolean DEFAULT false       NOT NULL,
    folder_uid character varying(40)
);


ALTER TABLE public.dashboard
    OWNER TO grafana;

--
-- Name: dashboard_acl; Type: TABLE; Schema: public; Owner: grafana
--

CREATE TABLE public.dashboard_acl
(
    id           integer                     NOT NULL,
    org_id       bigint                      NOT NULL,
    dashboard_id bigint                      NOT NULL,
    user_id      bigint,
    team_id      bigint,
    permission   smallint DEFAULT 4          NOT NULL,
    role         character varying(20),
    created      timestamp without time zone NOT NULL,
    updated      timestamp without time zone NOT NULL
);


ALTER TABLE public.dashboard_acl
    OWNER TO grafana;

--
-- Name: dashboard_acl_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana
--

CREATE SEQUENCE public.dashboard_acl_id_seq AS integer
START
1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dashboard_acl_id_seq
    OWNER TO grafana;

--
-- Name: dashboard_acl_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana
--

ALTER SEQUENCE public.dashboard_acl_id_seq OWNED BY public.dashboard_acl.id;


--
-- Name: dashboard_id_seq1; Type: SEQUENCE; Schema: public; Owner: grafana
--

CREATE SEQUENCE public.dashboard_id_seq1 AS integer
START
1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dashboard_id_seq1
    OWNER TO grafana;

--
-- Name: dashboard_id_seq1; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana
--

ALTER SEQUENCE public.dashboard_id_seq1 OWNED BY public.dashboard.id;


--
-- Name: dashboard_provisioning; Type: TABLE; Schema: public; Owner: grafana
--

CREATE TABLE public.dashboard_provisioning
(
    id           integer                NOT NULL,
    dashboard_id bigint,
    name         character varying(150) NOT NULL,
    external_id  text                   NOT NULL,
    updated      integer DEFAULT 0      NOT NULL,
    check_sum    character varying(32)
);


ALTER TABLE public.dashboard_provisioning
    OWNER TO grafana;

--
-- Name: dashboard_provisioning_id_seq1; Type: SEQUENCE; Schema: public; Owner: grafana
--

CREATE SEQUENCE public.dashboard_provisioning_id_seq1 AS integer
START
1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dashboard_provisioning_id_seq1
    OWNER TO grafana;

--
-- Name: dashboard_provisioning_id_seq1; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana
--

ALTER SEQUENCE public.dashboard_provisioning_id_seq1 OWNED BY public.dashboard_provisioning.id;


--
-- Name: dashboard_public; Type: TABLE; Schema: public; Owner: grafana
--

CREATE TABLE public.dashboard_public
(
    uid                    character varying(40)                                     NOT NULL,
    dashboard_uid          character varying(40)                                     NOT NULL,
    org_id                 bigint                                                    NOT NULL,
    time_settings          text,
    template_variables     text,
    access_token           character varying(32)                                     NOT NULL,
    created_by             integer                                                   NOT NULL,
    updated_by             integer,
    created_at             timestamp without time zone                               NOT NULL,
    updated_at             timestamp without time zone,
    is_enabled             boolean               DEFAULT false                       NOT NULL,
    annotations_enabled    boolean               DEFAULT false                       NOT NULL,
    time_selection_enabled boolean               DEFAULT false                       NOT NULL,
    share                  character varying(64) DEFAULT 'public'::character varying NOT NULL
);


ALTER TABLE public.dashboard_public
    OWNER TO grafana;

--
-- Name: dashboard_snapshot; Type: TABLE; Schema: public; Owner: grafana
--

CREATE TABLE public.dashboard_snapshot
(
    id                  integer                     NOT NULL,
    name                character varying(255)      NOT NULL,
    key                 character varying(190)      NOT NULL,
    delete_key          character varying(190)      NOT NULL,
    org_id              bigint                      NOT NULL,
    user_id             bigint                      NOT NULL,
    external            boolean                     NOT NULL,
    external_url        character varying(255)      NOT NULL,
    dashboard           text                        NOT NULL,
    expires             timestamp without time zone NOT NULL,
    created             timestamp without time zone NOT NULL,
    updated             timestamp without time zone NOT NULL,
    external_delete_url character varying(255),
    dashboard_encrypted bytea
);


ALTER TABLE public.dashboard_snapshot
    OWNER TO grafana;

--
-- Name: dashboard_snapshot_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana
--

CREATE SEQUENCE public.dashboard_snapshot_id_seq AS integer
START
1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dashboard_snapshot_id_seq
    OWNER TO grafana;


--
-- Name: dashboard_snapshot_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana
--

ALTER SEQUENCE public.dashboard_snapshot_id_seq OWNED BY public.dashboard_snapshot.id;


--
-- Name: dashboard_tag; Type: TABLE; Schema: public; Owner: grafana
--

CREATE TABLE public.dashboard_tag
(
    id           integer               NOT NULL,
    dashboard_id bigint                NOT NULL,
    term         character varying(50) NOT NULL
);


ALTER TABLE public.dashboard_tag
    OWNER TO grafana;

--
-- Name: dashboard_tag_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana
--

CREATE SEQUENCE public.dashboard_tag_id_seq AS integer
START
1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dashboard_tag_id_seq
    OWNER TO grafana;

--
-- Name: dashboard_tag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana
--

ALTER SEQUENCE public.dashboard_tag_id_seq OWNED BY public.dashboard_tag.id;


--
-- Name: dashboard_version; Type: TABLE; Schema: public; Owner: grafana
--

CREATE TABLE public.dashboard_version
(
    id             integer                     NOT NULL,
    dashboard_id   bigint                      NOT NULL,
    parent_version integer                     NOT NULL,
    restored_from  integer                     NOT NULL,
    version        integer                     NOT NULL,
    created        timestamp without time zone NOT NULL,
    created_by     bigint                      NOT NULL,
    message        text                        NOT NULL,
    data           text                        NOT NULL
);


ALTER TABLE public.dashboard_version
    OWNER TO grafana;

--
-- Name: dashboard_version_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana
--

CREATE SEQUENCE public.dashboard_version_id_seq AS integer
START
1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dashboard_version_id_seq
    OWNER TO grafana;

--
-- Name: dashboard_version_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana
--

ALTER SEQUENCE public.dashboard_version_id_seq OWNED BY public.dashboard_version.id;


--
-- Name: data_keys; Type: TABLE; Schema: public; Owner: grafana
--

CREATE TABLE public.data_keys
(
    name           character varying(100)                               NOT NULL,
    active         boolean                                              NOT NULL,
    scope          character varying(30)                                NOT NULL,
    provider       character varying(50)                                NOT NULL,
    encrypted_data bytea                                                NOT NULL,
    created        timestamp without time zone                          NOT NULL,
    updated        timestamp without time zone                          NOT NULL,
    label          character varying(100) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.data_keys
    OWNER TO grafana;

--
-- Name: data_source; Type: TABLE; Schema: public; Owner: grafana
--

CREATE TABLE public.data_source
(
    id                  integer                             NOT NULL,
    org_id              bigint                              NOT NULL,
    version             integer                             NOT NULL,
    type                character varying(255)              NOT NULL,
    name                character varying(190)              NOT NULL,
    access              character varying(255)              NOT NULL,
    url                 character varying(255)              NOT NULL,
    password            character varying(255),
    "user"              character varying(255),
    database            character varying(255),
    basic_auth          boolean                             NOT NULL,
    basic_auth_user     character varying(255),
    basic_auth_password character varying(255),
    is_default          boolean                             NOT NULL,
    json_data           text,
    created             timestamp without time zone         NOT NULL,
    updated             timestamp without time zone         NOT NULL,
    with_credentials    boolean               DEFAULT false NOT NULL,
    secure_json_data    text,
    read_only           boolean,
    uid                 character varying(40) DEFAULT 0     NOT NULL
);


ALTER TABLE public.data_source
    OWNER TO grafana;

--
-- Name: data_source_id_seq1; Type: SEQUENCE; Schema: public; Owner: grafana
--

CREATE SEQUENCE public.data_source_id_seq1 AS integer
START
1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.data_source_id_seq1
    OWNER TO grafana;

--
-- Name: data_source_id_seq1; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana
--

ALTER SEQUENCE public.data_source_id_seq1 OWNED BY public.data_source.id;


--
-- Name: entity_event; Type: TABLE; Schema: public; Owner: grafana
--

CREATE TABLE public.entity_event
(
    id         integer                 NOT NULL,
    entity_id  character varying(1024) NOT NULL,
    event_type character varying(8)    NOT NULL,
    created    bigint                  NOT NULL
);


ALTER TABLE public.entity_event
    OWNER TO grafana;

--
-- Name: entity_event_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana
--

CREATE SEQUENCE public.entity_event_id_seq AS integer
START
1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.entity_event_id_seq
    OWNER TO grafana;

--
-- Name: entity_event_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana
--

ALTER SEQUENCE public.entity_event_id_seq OWNED BY public.entity_event.id;


--
-- Name: file; Type: TABLE; Schema: public; Owner: grafana
--


CREATE TABLE if not exists public.file
(
    path                    character varying(1024)     NOT NULL COLLATE "en-US",
    path_hash               character varying(64)       NOT NULL,
    parent_folder_path_hash character varying(64)       NOT NULL,
    contents                bytea                       NOT NULL,
    etag                    character varying(32)       NOT NULL,
    cache_control           character varying(128)      NOT NULL,
    content_disposition     character varying(128)      NOT NULL,
    updated                 timestamp without time zone NOT NULL,
    created                 timestamp without time zone NOT NULL,
    size                    bigint                      NOT NULL,
    mime_type               character varying(255)      NOT NULL
);

ALTER TABLE public.file
    OWNER TO grafana;

--
-- Name: file_meta; Type: TABLE; Schema: public; Owner: grafana
--

CREATE TABLE public.file_meta
(
    path_hash character varying(64)   NOT NULL,
    key       character varying(191)  NOT NULL,
    value     character varying(1024) NOT NULL
);


ALTER TABLE public.file_meta
    OWNER TO grafana;

--
-- Name: folder; Type: TABLE; Schema: public; Owner: grafana
--

CREATE TABLE public.folder
(
    id          integer                     NOT NULL,
    uid         character varying(40)       NOT NULL,
    org_id      bigint                      NOT NULL,
    title       character varying(189)      NOT NULL,
    description character varying(255),
    parent_uid  character varying(40),
    created     timestamp without time zone NOT NULL,
    updated     timestamp without time zone NOT NULL
);


ALTER TABLE public.folder
    OWNER TO grafana;

--
-- Name: folder_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana
--

CREATE SEQUENCE public.folder_id_seq AS integer
START
1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.folder_id_seq
    OWNER TO grafana;

--
-- Name: folder_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana
--

ALTER SEQUENCE public.folder_id_seq OWNED BY public.folder.id;


--
-- Name: kv_store; Type: TABLE; Schema: public; Owner: grafana
--

CREATE TABLE public.kv_store
(
    id        integer                     NOT NULL,
    org_id    bigint                      NOT NULL,
    namespace character varying(190)      NOT NULL,
    key       character varying(190)      NOT NULL,
    value     text                        NOT NULL,
    created   timestamp without time zone NOT NULL,
    updated   timestamp without time zone NOT NULL
);


ALTER TABLE public.kv_store
    OWNER TO grafana;

--
-- Name: kv_store_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana
--

CREATE SEQUENCE public.kv_store_id_seq AS integer
START
1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.kv_store_id_seq
    OWNER TO grafana;

--
-- Name: kv_store_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana
--

ALTER SEQUENCE public.kv_store_id_seq OWNED BY public.kv_store.id;


--
-- Name: library_element; Type: TABLE; Schema: public; Owner: grafana
--

CREATE TABLE public.library_element
(
    id          integer                     NOT NULL,
    org_id      bigint                      NOT NULL,
    folder_id   bigint                      NOT NULL,
    uid         character varying(40)       NOT NULL,
    name        character varying(150)      NOT NULL,
    kind        bigint                      NOT NULL,
    type        character varying(40)       NOT NULL,
    description character varying(2048)     NOT NULL,
    model       text                        NOT NULL,
    created     timestamp without time zone NOT NULL,
    created_by  bigint                      NOT NULL,
    updated     timestamp without time zone NOT NULL,
    updated_by  bigint                      NOT NULL,
    version     bigint                      NOT NULL
);


ALTER TABLE public.library_element
    OWNER TO grafana;

--
-- Name: library_element_connection; Type: TABLE; Schema: public; Owner: grafana
--

CREATE TABLE public.library_element_connection
(
    id            integer                     NOT NULL,
    element_id    bigint                      NOT NULL,
    kind          bigint                      NOT NULL,
    connection_id bigint                      NOT NULL,
    created       timestamp without time zone NOT NULL,
    created_by    bigint                      NOT NULL
);


ALTER TABLE public.library_element_connection
    OWNER TO grafana;

--
-- Name: library_element_connection_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana
--

CREATE SEQUENCE public.library_element_connection_id_seq AS integer
START
1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.library_element_connection_id_seq
    OWNER TO grafana;

--
-- Name: library_element_connection_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana
--

ALTER SEQUENCE public.library_element_connection_id_seq OWNED BY public.library_element_connection.id;


--
-- Name: library_element_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana
--

CREATE SEQUENCE public.library_element_id_seq AS integer
START
1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.library_element_id_seq
    OWNER TO grafana;

--
-- Name: library_element_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana
--

ALTER SEQUENCE public.library_element_id_seq OWNED BY public.library_element.id;


--
-- Name: login_attempt; Type: TABLE; Schema: public; Owner: grafana
--

CREATE TABLE public.login_attempt
(
    id         integer                NOT NULL,
    username   character varying(190) NOT NULL,
    ip_address character varying(30)  NOT NULL,
    created    integer DEFAULT 0      NOT NULL
);


ALTER TABLE public.login_attempt
    OWNER TO grafana;

--
-- Name: login_attempt_id_seq1; Type: SEQUENCE; Schema: public; Owner: grafana
--

CREATE SEQUENCE public.login_attempt_id_seq1 AS integer
START
1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.login_attempt_id_seq1
    OWNER TO grafana;

--
-- Name: login_attempt_id_seq1; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana
--

ALTER SEQUENCE public.login_attempt_id_seq1 OWNED BY public.login_attempt.id;


--
-- Name: migration_log; Type: TABLE; Schema: public; Owner: grafana
--

CREATE TABLE public.migration_log
(
    id           integer                     NOT NULL,
    migration_id character varying(255)      NOT NULL,
    sql          text                        NOT NULL,
    success      boolean                     NOT NULL,
    error        text                        NOT NULL,
    "timestamp"  timestamp without time zone NOT NULL
);


ALTER TABLE public.migration_log
    OWNER TO grafana;

--
-- Name: migration_log_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana
--

CREATE SEQUENCE public.migration_log_id_seq AS integer
START
1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.migration_log_id_seq
    OWNER TO grafana;

--
-- Name: migration_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana
--

ALTER SEQUENCE public.migration_log_id_seq OWNED BY public.migration_log.id;


--
-- Name: ngalert_configuration; Type: TABLE; Schema: public; Owner: grafana
--

CREATE TABLE public.ngalert_configuration
(
    id             integer            NOT NULL,
    org_id         bigint             NOT NULL,
    alertmanagers  text,
    created_at     integer            NOT NULL,
    updated_at     integer            NOT NULL,
    send_alerts_to smallint DEFAULT 0 NOT NULL
);


ALTER TABLE public.ngalert_configuration
    OWNER TO grafana;

--
-- Name: ngalert_configuration_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana
--

CREATE SEQUENCE public.ngalert_configuration_id_seq AS integer
START
1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ngalert_configuration_id_seq
    OWNER TO grafana;

--
-- Name: ngalert_configuration_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana
--

ALTER SEQUENCE public.ngalert_configuration_id_seq OWNED BY public.ngalert_configuration.id;


--
-- Name: org; Type: TABLE; Schema: public; Owner: grafana
--

CREATE TABLE public.org
(
    id            integer                     NOT NULL,
    version       integer                     NOT NULL,
    name          character varying(190)      NOT NULL,
    address1      character varying(255),
    address2      character varying(255),
    city          character varying(255),
    state         character varying(255),
    zip_code      character varying(50),
    country       character varying(255),
    billing_email character varying(255),
    created       timestamp without time zone NOT NULL,
    updated       timestamp without time zone NOT NULL
);


ALTER TABLE public.org
    OWNER TO grafana;

--
-- Name: org_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana
--

CREATE SEQUENCE public.org_id_seq AS integer
START
1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.org_id_seq
    OWNER TO grafana;

--
-- Name: org_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana
--

ALTER SEQUENCE public.org_id_seq OWNED BY public.org.id;


--
-- Name: org_user; Type: TABLE; Schema: public; Owner: grafana
--

CREATE TABLE public.org_user
(
    id      integer                     NOT NULL,
    org_id  bigint                      NOT NULL,
    user_id bigint                      NOT NULL,
    role    character varying(20)       NOT NULL,
    created timestamp without time zone NOT NULL,
    updated timestamp without time zone NOT NULL
);


ALTER TABLE public.org_user
    OWNER TO grafana;

--
-- Name: org_user_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana
--

CREATE SEQUENCE public.org_user_id_seq AS integer
START
1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.org_user_id_seq
    OWNER TO grafana;

--
-- Name: org_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana
--

ALTER SEQUENCE public.org_user_id_seq OWNED BY public.org_user.id;


--
-- Name: permission; Type: TABLE; Schema: public; Owner: grafana
--

CREATE TABLE public.permission
(
    id         integer                                             NOT NULL,
    role_id    bigint                                              NOT NULL,
    action     character varying(190)                              NOT NULL,
    scope      character varying(190)                              NOT NULL,
    created    timestamp without time zone                         NOT NULL,
    updated    timestamp without time zone                         NOT NULL,
    kind       character varying(40) DEFAULT ''::character varying NOT NULL,
    attribute  character varying(40) DEFAULT ''::character varying NOT NULL,
    identifier character varying(40) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.permission
    OWNER TO grafana;

--
-- Name: permission_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana
--

CREATE SEQUENCE public.permission_id_seq AS integer
START
1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.permission_id_seq
    OWNER TO grafana;

--
-- Name: permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana
--

ALTER SEQUENCE public.permission_id_seq OWNED BY public.permission.id;


--
-- Name: playlist; Type: TABLE; Schema: public; Owner: grafana
--

CREATE TABLE public.playlist
(
    id         integer                         NOT NULL,
    name       character varying(255)          NOT NULL,
    "interval" character varying(255)          NOT NULL,
    org_id     bigint                          NOT NULL,
    created_at bigint                DEFAULT 0 NOT NULL,
    updated_at bigint                DEFAULT 0 NOT NULL,
    uid        character varying(80) DEFAULT 0 NOT NULL
);


ALTER TABLE public.playlist
    OWNER TO grafana;

--
-- Name: playlist_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana
--

CREATE SEQUENCE public.playlist_id_seq AS integer
START
1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.playlist_id_seq
    OWNER TO grafana;

--
-- Name: playlist_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana
--

ALTER SEQUENCE public.playlist_id_seq OWNED BY public.playlist.id;


--
-- Name: playlist_item; Type: TABLE; Schema: public; Owner: grafana
--

CREATE TABLE public.playlist_item
(
    id          integer                NOT NULL,
    playlist_id bigint                 NOT NULL,
    type        character varying(255) NOT NULL,
    value       text                   NOT NULL,
    title       text                   NOT NULL,
    "order"     integer                NOT NULL
);


ALTER TABLE public.playlist_item
    OWNER TO grafana;

--
-- Name: playlist_item_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana
--

CREATE SEQUENCE public.playlist_item_id_seq AS integer
START
1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.playlist_item_id_seq
    OWNER TO grafana;

--
-- Name: playlist_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana
--

ALTER SEQUENCE public.playlist_item_id_seq OWNED BY public.playlist_item.id;


--
-- Name: plugin_setting; Type: TABLE; Schema: public; Owner: grafana
--

CREATE TABLE public.plugin_setting
(
    id               integer                     NOT NULL,
    org_id           bigint,
    plugin_id        character varying(190)      NOT NULL,
    enabled          boolean                     NOT NULL,
    pinned           boolean                     NOT NULL,
    json_data        text,
    secure_json_data text,
    created          timestamp without time zone NOT NULL,
    updated          timestamp without time zone NOT NULL,
    plugin_version   character varying(50)
);


ALTER TABLE public.plugin_setting
    OWNER TO grafana;

--
-- Name: plugin_setting_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana
--

CREATE SEQUENCE public.plugin_setting_id_seq AS integer
START
1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.plugin_setting_id_seq
    OWNER TO grafana;

--
-- Name: plugin_setting_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana
--

ALTER SEQUENCE public.plugin_setting_id_seq OWNED BY public.plugin_setting.id;


--
-- Name: preferences; Type: TABLE; Schema: public; Owner: grafana
--

CREATE TABLE public.preferences
(
    id                integer                     NOT NULL,
    org_id            bigint                      NOT NULL,
    user_id           bigint                      NOT NULL,
    version           integer                     NOT NULL,
    home_dashboard_id bigint                      NOT NULL,
    timezone          character varying(50)       NOT NULL,
    theme             character varying(20)       NOT NULL,
    created           timestamp without time zone NOT NULL,
    updated           timestamp without time zone NOT NULL,
    team_id           bigint,
    week_start        character varying(10),
    json_data         text
);


ALTER TABLE public.preferences
    OWNER TO grafana;

--
-- Name: preferences_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana
--

CREATE SEQUENCE public.preferences_id_seq AS integer
START
1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.preferences_id_seq
    OWNER TO grafana;

--
-- Name: preferences_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana
--

ALTER SEQUENCE public.preferences_id_seq OWNED BY public.preferences.id;


--
-- Name: provenance_type; Type: TABLE; Schema: public; Owner: grafana
--

CREATE TABLE public.provenance_type
(
    id          integer                NOT NULL,
    org_id      bigint                 NOT NULL,
    record_key  character varying(190) NOT NULL,
    record_type character varying(190) NOT NULL,
    provenance  character varying(190) NOT NULL
);


ALTER TABLE public.provenance_type
    OWNER TO grafana;

--
-- Name: provenance_type_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana
--

CREATE SEQUENCE public.provenance_type_id_seq AS integer
START
1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.provenance_type_id_seq
    OWNER TO grafana;

--
-- Name: provenance_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana
--

ALTER SEQUENCE public.provenance_type_id_seq OWNED BY public.provenance_type.id;


--
-- Name: query_history; Type: TABLE; Schema: public; Owner: grafana
--

CREATE TABLE public.query_history
(
    id             integer               NOT NULL,
    uid            character varying(40) NOT NULL,
    org_id         bigint                NOT NULL,
    datasource_uid character varying(40) NOT NULL,
    created_by     bigint                NOT NULL,
    created_at     integer               NOT NULL,
    comment        text                  NOT NULL,
    queries        text                  NOT NULL
);


ALTER TABLE public.query_history
    OWNER TO grafana;

--
-- Name: query_history_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana
--

CREATE SEQUENCE public.query_history_id_seq AS integer
START
1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.query_history_id_seq
    OWNER TO grafana;

--
-- Name: query_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana
--

ALTER SEQUENCE public.query_history_id_seq OWNED BY public.query_history.id;


--
-- Name: query_history_star; Type: TABLE; Schema: public; Owner: grafana
--

CREATE TABLE public.query_history_star
(
    id        integer               NOT NULL,
    query_uid character varying(40) NOT NULL,
    user_id   bigint                NOT NULL,
    org_id    bigint DEFAULT 1      NOT NULL
);


ALTER TABLE public.query_history_star
    OWNER TO grafana;

--
-- Name: query_history_star_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana
--

CREATE SEQUENCE public.query_history_star_id_seq AS integer
START
1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.query_history_star_id_seq
    OWNER TO grafana;

--
-- Name: query_history_star_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana
--

ALTER SEQUENCE public.query_history_star_id_seq OWNED BY public.query_history_star.id;


--
-- Name: quota; Type: TABLE; Schema: public; Owner: grafana
--

CREATE TABLE public.quota
(
    id      integer                     NOT NULL,
    org_id  bigint,
    user_id bigint,
    target  character varying(190)      NOT NULL,
    "limit" bigint                      NOT NULL,
    created timestamp without time zone NOT NULL,
    updated timestamp without time zone NOT NULL
);


ALTER TABLE public.quota
    OWNER TO grafana;

--
-- Name: quota_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana
--

CREATE SEQUENCE public.quota_id_seq AS integer
START
1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.quota_id_seq
    OWNER TO grafana;

--
-- Name: quota_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana
--

ALTER SEQUENCE public.quota_id_seq OWNED BY public.quota.id;


--
-- Name: role; Type: TABLE; Schema: public; Owner: grafana
--

CREATE TABLE public.role
(
    id           integer                     NOT NULL,
    name         character varying(190)      NOT NULL,
    description  text,
    version      bigint                      NOT NULL,
    org_id       bigint                      NOT NULL,
    uid          character varying(40)       NOT NULL,
    created      timestamp without time zone NOT NULL,
    updated      timestamp without time zone NOT NULL,
    display_name character varying(190),
    group_name   character varying(190),
    hidden       boolean DEFAULT false       NOT NULL
);


ALTER TABLE public.role
    OWNER TO grafana;

--
-- Name: role_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana
--

CREATE SEQUENCE public.role_id_seq AS integer
START
1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.role_id_seq
    OWNER TO grafana;

--
-- Name: role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana
--

ALTER SEQUENCE public.role_id_seq OWNED BY public.role.id;


--
-- Name: secrets; Type: TABLE; Schema: public; Owner: grafana
--

CREATE TABLE public.secrets
(
    id        integer                     NOT NULL,
    org_id    bigint                      NOT NULL,
    namespace character varying(255)      NOT NULL,
    type      character varying(255)      NOT NULL,
    value     text,
    created   timestamp without time zone NOT NULL,
    updated   timestamp without time zone NOT NULL
);


ALTER TABLE public.secrets
    OWNER TO grafana;

--
-- Name: secrets_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana
--

CREATE SEQUENCE public.secrets_id_seq AS integer
START
1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.secrets_id_seq
    OWNER TO grafana;

--
-- Name: secrets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana
--

ALTER SEQUENCE public.secrets_id_seq OWNED BY public.secrets.id;


--
-- Name: seed_assignment; Type: TABLE; Schema: public; Owner: grafana
--

CREATE TABLE public.seed_assignment
(
    builtin_role character varying(190) NOT NULL,
    role_name    character varying(190),
    action       character varying(190),
    scope        character varying(190),
    id           integer                NOT NULL,
    origin       character varying(190)
);


ALTER TABLE public.seed_assignment
    OWNER TO grafana;

--
-- Name: seed_assignment_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana
--

CREATE SEQUENCE public.seed_assignment_id_seq AS integer
START
1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seed_assignment_id_seq
    OWNER TO grafana;

--
-- Name: seed_assignment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana
--

ALTER SEQUENCE public.seed_assignment_id_seq OWNED BY public.seed_assignment.id;


--
-- Name: server_lock; Type: TABLE; Schema: public; Owner: grafana
--

CREATE TABLE public.server_lock
(
    id             integer                NOT NULL,
    operation_uid  character varying(100) NOT NULL,
    version        bigint                 NOT NULL,
    last_execution bigint                 NOT NULL
);


ALTER TABLE public.server_lock
    OWNER TO grafana;

--
-- Name: server_lock_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana
--

CREATE SEQUENCE public.server_lock_id_seq AS integer
START
1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.server_lock_id_seq
    OWNER TO grafana;

--
-- Name: server_lock_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana
--

ALTER SEQUENCE public.server_lock_id_seq OWNED BY public.server_lock.id;


--
-- Name: session; Type: TABLE; Schema: public; Owner: grafana
--

CREATE TABLE public.session
(
    key    character(16) NOT NULL,
    data   bytea         NOT NULL,
    expiry integer       NOT NULL
);


ALTER TABLE public.session
    OWNER TO grafana;

--
-- Name: short_url; Type: TABLE; Schema: public; Owner: grafana
--

CREATE TABLE public.short_url
(
    id           integer               NOT NULL,
    org_id       bigint                NOT NULL,
    uid          character varying(40) NOT NULL,
    path         text                  NOT NULL,
    created_by   bigint                NOT NULL,
    created_at   integer               NOT NULL,
    last_seen_at integer
);


ALTER TABLE public.short_url
    OWNER TO grafana;

--
-- Name: short_url_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana
--

CREATE SEQUENCE public.short_url_id_seq AS integer
START
1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.short_url_id_seq
    OWNER TO grafana;

--
-- Name: short_url_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana
--

ALTER SEQUENCE public.short_url_id_seq OWNED BY public.short_url.id;


--
-- Name: signing_key; Type: TABLE; Schema: public; Owner: grafana
--

CREATE TABLE public.signing_key
(
    id          integer                     NOT NULL,
    key_id      character varying(255)      NOT NULL,
    private_key text                        NOT NULL,
    added_at    timestamp without time zone NOT NULL,
    expires_at  timestamp without time zone,
    alg         character varying(255)      NOT NULL
);


ALTER TABLE public.signing_key
    OWNER TO grafana;

--
-- Name: signing_key_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana
--

CREATE SEQUENCE public.signing_key_id_seq AS integer
START
1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.signing_key_id_seq
    OWNER TO grafana;

--
-- Name: signing_key_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana
--

ALTER SEQUENCE public.signing_key_id_seq OWNED BY public.signing_key.id;


--
-- Name: sso_setting; Type: TABLE; Schema: public; Owner: grafana
--

CREATE TABLE public.sso_setting
(
    id         character varying(40)       NOT NULL,
    provider   character varying(255)      NOT NULL,
    settings   text                        NOT NULL,
    created    timestamp without time zone NOT NULL,
    updated    timestamp without time zone NOT NULL,
    is_deleted boolean DEFAULT false       NOT NULL
);


ALTER TABLE public.sso_setting
    OWNER TO grafana;

--
-- Name: star; Type: TABLE; Schema: public; Owner: grafana
--

CREATE TABLE public.star
(
    id           integer NOT NULL,
    user_id      bigint  NOT NULL,
    dashboard_id bigint  NOT NULL
);


ALTER TABLE public.star
    OWNER TO grafana;

--
-- Name: star_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana
--

CREATE SEQUENCE public.star_id_seq AS integer
START
1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.star_id_seq
    OWNER TO grafana;

--
-- Name: star_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana
--

ALTER SEQUENCE public.star_id_seq OWNED BY public.star.id;


--
-- Name: tag; Type: TABLE; Schema: public; Owner: grafana
--

CREATE TABLE public.tag
(
    id    integer                NOT NULL,
    key   character varying(100) NOT NULL,
    value character varying(100) NOT NULL
);


ALTER TABLE public.tag
    OWNER TO grafana;

--
-- Name: tag_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana
--

CREATE SEQUENCE public.tag_id_seq AS integer
START
1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tag_id_seq
    OWNER TO grafana;

--
-- Name: tag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana
--

ALTER SEQUENCE public.tag_id_seq OWNED BY public.tag.id;


--
-- Name: team; Type: TABLE; Schema: public; Owner: grafana
--

CREATE TABLE public.team
(
    id      integer                     NOT NULL,
    name    character varying(190)      NOT NULL,
    org_id  bigint                      NOT NULL,
    created timestamp without time zone NOT NULL,
    updated timestamp without time zone NOT NULL,
    uid     character varying(40),
    email   character varying(190)
);


ALTER TABLE public.team
    OWNER TO grafana;

--
-- Name: team_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana
--

CREATE SEQUENCE public.team_id_seq AS integer
START
1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.team_id_seq
    OWNER TO grafana;

--
-- Name: team_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana
--

ALTER SEQUENCE public.team_id_seq OWNED BY public.team.id;


--
-- Name: team_member; Type: TABLE; Schema: public; Owner: grafana
--

CREATE TABLE public.team_member
(
    id         integer                     NOT NULL,
    org_id     bigint                      NOT NULL,
    team_id    bigint                      NOT NULL,
    user_id    bigint                      NOT NULL,
    created    timestamp without time zone NOT NULL,
    updated    timestamp without time zone NOT NULL,
    external   boolean,
    permission smallint
);


ALTER TABLE public.team_member
    OWNER TO grafana;

--
-- Name: team_member_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana
--

CREATE SEQUENCE public.team_member_id_seq AS integer
START
1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.team_member_id_seq
    OWNER TO grafana;

--
-- Name: team_member_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana
--

ALTER SEQUENCE public.team_member_id_seq OWNED BY public.team_member.id;


--
-- Name: team_role; Type: TABLE; Schema: public; Owner: grafana
--

CREATE TABLE public.team_role
(
    id      integer                     NOT NULL,
    org_id  bigint                      NOT NULL,
    team_id bigint                      NOT NULL,
    role_id bigint                      NOT NULL,
    created timestamp without time zone NOT NULL
);


ALTER TABLE public.team_role
    OWNER TO grafana;

--
-- Name: team_role_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana
--

CREATE SEQUENCE public.team_role_id_seq AS integer
START
1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.team_role_id_seq
    OWNER TO grafana;

--
-- Name: team_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana
--

ALTER SEQUENCE public.team_role_id_seq OWNED BY public.team_role.id;


--
-- Name: temp_user; Type: TABLE; Schema: public; Owner: grafana
--

CREATE TABLE public.temp_user
(
    id                 integer                NOT NULL,
    org_id             bigint                 NOT NULL,
    version            integer                NOT NULL,
    email              character varying(190) NOT NULL,
    name               character varying(255),
    role               character varying(20),
    code               character varying(190) NOT NULL,
    status             character varying(20)  NOT NULL,
    invited_by_user_id bigint,
    email_sent         boolean                NOT NULL,
    email_sent_on      timestamp without time zone,
    remote_addr        character varying(255),
    created            integer DEFAULT 0      NOT NULL,
    updated            integer DEFAULT 0      NOT NULL
);


ALTER TABLE public.temp_user
    OWNER TO grafana;

--
-- Name: temp_user_id_seq1; Type: SEQUENCE; Schema: public; Owner: grafana
--

CREATE SEQUENCE public.temp_user_id_seq1 AS integer
START
1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.temp_user_id_seq1
    OWNER TO grafana;

--
-- Name: temp_user_id_seq1; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana
--

ALTER SEQUENCE public.temp_user_id_seq1 OWNED BY public.temp_user.id;


--
-- Name: test_data; Type: TABLE; Schema: public; Owner: grafana
--

CREATE TABLE public.test_data
(
    id              integer                     NOT NULL,
    metric1         character varying(20),
    metric2         character varying(150),
    value_big_int   bigint,
    value_double    double precision,
    value_float     real,
    value_int       integer,
    time_epoch      bigint                      NOT NULL,
    time_date_time  timestamp without time zone NOT NULL,
    time_time_stamp timestamp without time zone NOT NULL
);


ALTER TABLE public.test_data
    OWNER TO grafana;

--
-- Name: test_data_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana
--

CREATE SEQUENCE public.test_data_id_seq AS integer
START
1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.test_data_id_seq
    OWNER TO grafana;

--
-- Name: test_data_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana
--

ALTER SEQUENCE public.test_data_id_seq OWNED BY public.test_data.id;


--
-- Name: user; Type: TABLE; Schema: public; Owner: grafana
--

CREATE TABLE public."user"
(
    id                 integer                     NOT NULL,
    version            integer                     NOT NULL,
    login              character varying(190)      NOT NULL,
    email              character varying(190)      NOT NULL,
    name               character varying(255),
    password           character varying(255),
    salt               character varying(50),
    rands              character varying(50),
    company            character varying(255),
    org_id             bigint                      NOT NULL,
    is_admin           boolean                     NOT NULL,
    email_verified     boolean,
    theme              character varying(255),
    created            timestamp without time zone NOT NULL,
    updated            timestamp without time zone NOT NULL,
    help_flags1        bigint  DEFAULT 0           NOT NULL,
    last_seen_at       timestamp without time zone,
    is_disabled        boolean DEFAULT false       NOT NULL,
    is_service_account boolean DEFAULT false,
    uid                character varying(40)
);


ALTER TABLE public."user"
    OWNER TO grafana;

--
-- Name: user_auth; Type: TABLE; Schema: public; Owner: grafana
--

CREATE TABLE public.user_auth
(
    id                   integer                     NOT NULL,
    user_id              bigint                      NOT NULL,
    auth_module          character varying(190)      NOT NULL,
    auth_id              character varying(190)      NOT NULL,
    created              timestamp without time zone NOT NULL,
    o_auth_access_token  text,
    o_auth_refresh_token text,
    o_auth_token_type    text,
    o_auth_expiry        timestamp without time zone,
    o_auth_id_token      text
);


ALTER TABLE public.user_auth
    OWNER TO grafana;

--
-- Name: user_auth_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana
--

CREATE SEQUENCE public.user_auth_id_seq AS integer
START
1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_auth_id_seq
    OWNER TO grafana;

--
-- Name: user_auth_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana
--

ALTER SEQUENCE public.user_auth_id_seq OWNED BY public.user_auth.id;


--
-- Name: user_auth_token; Type: TABLE; Schema: public; Owner: grafana
--

CREATE TABLE public.user_auth_token
(
    id              integer                NOT NULL,
    user_id         bigint                 NOT NULL,
    auth_token      character varying(100) NOT NULL,
    prev_auth_token character varying(100) NOT NULL,
    user_agent      character varying(255) NOT NULL,
    client_ip       character varying(255) NOT NULL,
    auth_token_seen boolean                NOT NULL,
    seen_at         integer,
    rotated_at      integer                NOT NULL,
    created_at      integer                NOT NULL,
    updated_at      integer                NOT NULL,
    revoked_at      integer
);


ALTER TABLE public.user_auth_token
    OWNER TO grafana;

--
-- Name: user_auth_token_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana
--

CREATE SEQUENCE public.user_auth_token_id_seq AS integer
START
1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_auth_token_id_seq
    OWNER TO grafana;

--
-- Name: user_auth_token_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana
--

ALTER SEQUENCE public.user_auth_token_id_seq OWNED BY public.user_auth_token.id;


--
-- Name: user_id_seq1; Type: SEQUENCE; Schema: public; Owner: grafana
--

CREATE SEQUENCE public.user_id_seq1 AS integer
START
1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_id_seq1
    OWNER TO grafana;

--
-- Name: user_id_seq1; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana
--

ALTER SEQUENCE public.user_id_seq1 OWNED BY public."user".id;


--
-- Name: user_role; Type: TABLE; Schema: public; Owner: grafana
--

CREATE TABLE public.user_role
(
    id      integer                     NOT NULL,
    org_id  bigint                      NOT NULL,
    user_id bigint                      NOT NULL,
    role_id bigint                      NOT NULL,
    created timestamp without time zone NOT NULL
);


ALTER TABLE public.user_role
    OWNER TO grafana;

--
-- Name: user_role_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana
--

CREATE SEQUENCE public.user_role_id_seq AS integer
START
1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_role_id_seq
    OWNER TO grafana;

--
-- Name: user_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana
--

ALTER SEQUENCE public.user_role_id_seq OWNED BY public.user_role.id;


--
-- Name: alert id; Type: DEFAULT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.alert
    ALTER COLUMN id SET DEFAULT nextval('public.alert_id_seq'::regclass);


--
-- Name: alert_configuration id; Type: DEFAULT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.alert_configuration
    ALTER COLUMN id SET DEFAULT nextval('public.alert_configuration_id_seq'::regclass);


--
-- Name: alert_configuration_history id; Type: DEFAULT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.alert_configuration_history
    ALTER COLUMN id SET DEFAULT nextval('public.alert_configuration_history_id_seq'::regclass);


--
-- Name: alert_image id; Type: DEFAULT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.alert_image
    ALTER COLUMN id SET DEFAULT nextval('public.alert_image_id_seq'::regclass);


--
-- Name: alert_notification id; Type: DEFAULT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.alert_notification
    ALTER COLUMN id SET DEFAULT nextval('public.alert_notification_id_seq'::regclass);


--
-- Name: alert_notification_state id; Type: DEFAULT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.alert_notification_state
    ALTER COLUMN id SET DEFAULT nextval('public.alert_notification_state_id_seq'::regclass);


--
-- Name: alert_rule id; Type: DEFAULT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.alert_rule
    ALTER COLUMN id SET DEFAULT nextval('public.alert_rule_id_seq'::regclass);


--
-- Name: alert_rule_tag id; Type: DEFAULT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.alert_rule_tag
    ALTER COLUMN id SET DEFAULT nextval('public.alert_rule_tag_id_seq'::regclass);


--
-- Name: alert_rule_version id; Type: DEFAULT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.alert_rule_version
    ALTER COLUMN id SET DEFAULT nextval('public.alert_rule_version_id_seq'::regclass);


--
-- Name: annotation id; Type: DEFAULT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.annotation
    ALTER COLUMN id SET DEFAULT nextval('public.annotation_id_seq'::regclass);


--
-- Name: annotation_tag id; Type: DEFAULT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.annotation_tag
    ALTER COLUMN id SET DEFAULT nextval('public.annotation_tag_id_seq'::regclass);


--
-- Name: anon_device id; Type: DEFAULT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.anon_device
    ALTER COLUMN id SET DEFAULT nextval('public.anon_device_id_seq'::regclass);


--
-- Name: api_key id; Type: DEFAULT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.api_key
    ALTER COLUMN id SET DEFAULT nextval('public.api_key_id_seq1'::regclass);


--
-- Name: builtin_role id; Type: DEFAULT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.builtin_role
    ALTER COLUMN id SET DEFAULT nextval('public.builtin_role_id_seq'::regclass);


--
-- Name: dashboard id; Type: DEFAULT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.dashboard
    ALTER COLUMN id SET DEFAULT nextval('public.dashboard_id_seq1'::regclass);


--
-- Name: dashboard_acl id; Type: DEFAULT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.dashboard_acl
    ALTER COLUMN id SET DEFAULT nextval('public.dashboard_acl_id_seq'::regclass);


--
-- Name: dashboard_provisioning id; Type: DEFAULT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.dashboard_provisioning
    ALTER COLUMN id SET DEFAULT nextval('public.dashboard_provisioning_id_seq1'::regclass);


--
-- Name: dashboard_snapshot id; Type: DEFAULT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.dashboard_snapshot
    ALTER COLUMN id SET DEFAULT nextval('public.dashboard_snapshot_id_seq'::regclass);


--
-- Name: dashboard_tag id; Type: DEFAULT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.dashboard_tag
    ALTER COLUMN id SET DEFAULT nextval('public.dashboard_tag_id_seq'::regclass);


--
-- Name: dashboard_version id; Type: DEFAULT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.dashboard_version
    ALTER COLUMN id SET DEFAULT nextval('public.dashboard_version_id_seq'::regclass);


--
-- Name: data_source id; Type: DEFAULT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.data_source
    ALTER COLUMN id SET DEFAULT nextval('public.data_source_id_seq1'::regclass);


--
-- Name: entity_event id; Type: DEFAULT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.entity_event
    ALTER COLUMN id SET DEFAULT nextval('public.entity_event_id_seq'::regclass);


--
-- Name: folder id; Type: DEFAULT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.folder
    ALTER COLUMN id SET DEFAULT nextval('public.folder_id_seq'::regclass);


--
-- Name: kv_store id; Type: DEFAULT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.kv_store
    ALTER COLUMN id SET DEFAULT nextval('public.kv_store_id_seq'::regclass);


--
-- Name: library_element id; Type: DEFAULT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.library_element
    ALTER COLUMN id SET DEFAULT nextval('public.library_element_id_seq'::regclass);


--
-- Name: library_element_connection id; Type: DEFAULT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.library_element_connection
    ALTER COLUMN id SET DEFAULT nextval('public.library_element_connection_id_seq'::regclass);


--
-- Name: login_attempt id; Type: DEFAULT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.login_attempt
    ALTER COLUMN id SET DEFAULT nextval('public.login_attempt_id_seq1'::regclass);


--
-- Name: migration_log id; Type: DEFAULT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.migration_log
    ALTER COLUMN id SET DEFAULT nextval('public.migration_log_id_seq'::regclass);


--
-- Name: ngalert_configuration id; Type: DEFAULT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.ngalert_configuration
    ALTER COLUMN id SET DEFAULT nextval('public.ngalert_configuration_id_seq'::regclass);


--
-- Name: org id; Type: DEFAULT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.org
    ALTER COLUMN id SET DEFAULT nextval('public.org_id_seq'::regclass);


--
-- Name: org_user id; Type: DEFAULT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.org_user
    ALTER COLUMN id SET DEFAULT nextval('public.org_user_id_seq'::regclass);


--
-- Name: permission id; Type: DEFAULT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.permission
    ALTER COLUMN id SET DEFAULT nextval('public.permission_id_seq'::regclass);


--
-- Name: playlist id; Type: DEFAULT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.playlist
    ALTER COLUMN id SET DEFAULT nextval('public.playlist_id_seq'::regclass);


--
-- Name: playlist_item id; Type: DEFAULT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.playlist_item
    ALTER COLUMN id SET DEFAULT nextval('public.playlist_item_id_seq'::regclass);


--
-- Name: plugin_setting id; Type: DEFAULT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.plugin_setting
    ALTER COLUMN id SET DEFAULT nextval('public.plugin_setting_id_seq'::regclass);


--
-- Name: preferences id; Type: DEFAULT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.preferences
    ALTER COLUMN id SET DEFAULT nextval('public.preferences_id_seq'::regclass);


--
-- Name: provenance_type id; Type: DEFAULT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.provenance_type
    ALTER COLUMN id SET DEFAULT nextval('public.provenance_type_id_seq'::regclass);


--
-- Name: query_history id; Type: DEFAULT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.query_history
    ALTER COLUMN id SET DEFAULT nextval('public.query_history_id_seq'::regclass);


--
-- Name: query_history_star id; Type: DEFAULT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.query_history_star
    ALTER COLUMN id SET DEFAULT nextval('public.query_history_star_id_seq'::regclass);


--
-- Name: quota id; Type: DEFAULT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.quota
    ALTER COLUMN id SET DEFAULT nextval('public.quota_id_seq'::regclass);


--
-- Name: role id; Type: DEFAULT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.role
    ALTER COLUMN id SET DEFAULT nextval('public.role_id_seq'::regclass);


--
-- Name: secrets id; Type: DEFAULT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.secrets
    ALTER COLUMN id SET DEFAULT nextval('public.secrets_id_seq'::regclass);


--
-- Name: seed_assignment id; Type: DEFAULT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.seed_assignment
    ALTER COLUMN id SET DEFAULT nextval('public.seed_assignment_id_seq'::regclass);


--
-- Name: server_lock id; Type: DEFAULT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.server_lock
    ALTER COLUMN id SET DEFAULT nextval('public.server_lock_id_seq'::regclass);


--
-- Name: short_url id; Type: DEFAULT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.short_url
    ALTER COLUMN id SET DEFAULT nextval('public.short_url_id_seq'::regclass);


--
-- Name: signing_key id; Type: DEFAULT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.signing_key
    ALTER COLUMN id SET DEFAULT nextval('public.signing_key_id_seq'::regclass);


--
-- Name: star id; Type: DEFAULT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.star
    ALTER COLUMN id SET DEFAULT nextval('public.star_id_seq'::regclass);


--
-- Name: tag id; Type: DEFAULT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.tag
    ALTER COLUMN id SET DEFAULT nextval('public.tag_id_seq'::regclass);


--
-- Name: team id; Type: DEFAULT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.team
    ALTER COLUMN id SET DEFAULT nextval('public.team_id_seq'::regclass);


--
-- Name: team_member id; Type: DEFAULT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.team_member
    ALTER COLUMN id SET DEFAULT nextval('public.team_member_id_seq'::regclass);


--
-- Name: team_role id; Type: DEFAULT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.team_role
    ALTER COLUMN id SET DEFAULT nextval('public.team_role_id_seq'::regclass);


--
-- Name: temp_user id; Type: DEFAULT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.temp_user
    ALTER COLUMN id SET DEFAULT nextval('public.temp_user_id_seq1'::regclass);


--
-- Name: test_data id; Type: DEFAULT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.test_data
    ALTER COLUMN id SET DEFAULT nextval('public.test_data_id_seq'::regclass);


--
-- Name: user id; Type: DEFAULT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public."user"
    ALTER COLUMN id SET DEFAULT nextval('public.user_id_seq1'::regclass);


--
-- Name: user_auth id; Type: DEFAULT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.user_auth
    ALTER COLUMN id SET DEFAULT nextval('public.user_auth_id_seq'::regclass);


--
-- Name: user_auth_token id; Type: DEFAULT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.user_auth_token
    ALTER COLUMN id SET DEFAULT nextval('public.user_auth_token_id_seq'::regclass);


--
-- Name: user_role id; Type: DEFAULT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.user_role
    ALTER COLUMN id SET DEFAULT nextval('public.user_role_id_seq'::regclass);


--
-- Data for Name: alert; Type: TABLE DATA; Schema: public; Owner: grafana
--

-- COPY public.alert (id, version, dashboard_id, panel_id, org_id, name, message, state, settings, frequency, handler,
--                    severity, silenced, execution_error, eval_data, eval_date, new_state_date, state_changes, created,
--                    updated, "for") FROM stdin;
-- \.


--
-- Data for Name: alert_configuration; Type: TABLE DATA; Schema: public; Owner: grafana
--

COPY public.alert_configuration (id, alertmanager_configuration, configuration_version, created_at, "default", org_id,
                                 configuration_hash) FROM stdin;
1	{\n\t"alertmanager_config": {\n\t\t"route": {\n\t\t\t"receiver": "grafana-default-email",\n\t\t\t"group_by": ["grafana_folder", "alertname"]\n\t\t},\n\t\t"receivers": [{\n\t\t\t"name": "grafana-default-email",\n\t\t\t"grafana_managed_receiver_configs": [{\n\t\t\t\t"uid": "",\n\t\t\t\t"name": "email receiver",\n\t\t\t\t"type": "email",\n\t\t\t\t"isDefault": true,\n\t\t\t\t"settings": {\n\t\t\t\t\t"addresses": "<example@email.com>"\n\t\t\t\t}\n\t\t\t}]\n\t\t}]\n\t}\n}\n	v1	1711376420	t	1	e0528a75784033ae7b15c40851d89484
\.


--
-- Data for Name: alert_configuration_history; Type: TABLE DATA; Schema: public; Owner: grafana
--

COPY public.alert_configuration_history (id, org_id, alertmanager_configuration, configuration_hash,
                                         configuration_version, created_at, "default", last_applied) FROM stdin;
1	1	{\n\t"alertmanager_config": {\n\t\t"route": {\n\t\t\t"receiver": "grafana-default-email",\n\t\t\t"group_by": ["grafana_folder", "alertname"]\n\t\t},\n\t\t"receivers": [{\n\t\t\t"name": "grafana-default-email",\n\t\t\t"grafana_managed_receiver_configs": [{\n\t\t\t\t"uid": "",\n\t\t\t\t"name": "email receiver",\n\t\t\t\t"type": "email",\n\t\t\t\t"isDefault": true,\n\t\t\t\t"settings": {\n\t\t\t\t\t"addresses": "<example@email.com>"\n\t\t\t\t}\n\t\t\t}]\n\t\t}]\n\t}\n}\n	e0528a75784033ae7b15c40851d89484	v1	1711376420	t	1711390705
\.


--
-- Data for Name: alert_image; Type: TABLE DATA; Schema: public; Owner: grafana
--

COPY public.alert_image (id, token, path, url, created_at, expires_at) FROM stdin;
\.


--
-- Data for Name: alert_instance; Type: TABLE DATA; Schema: public; Owner: grafana
--

COPY public.alert_instance (rule_org_id, rule_uid, labels, labels_hash, current_state, current_state_since,
                            last_eval_time, current_state_end, current_reason, result_fingerprint) FROM stdin;
\.


--
-- Data for Name: alert_notification; Type: TABLE DATA; Schema: public; Owner: grafana
--

COPY public.alert_notification (id, org_id, name, type, settings, created, updated, is_default, frequency,
                                send_reminder, disable_resolve_message, uid, secure_settings) FROM stdin;
\.


--
-- Data for Name: alert_notification_state; Type: TABLE DATA; Schema: public; Owner: grafana
--

COPY public.alert_notification_state (id, org_id, alert_id, notifier_id, state, version, updated_at,
                                      alert_rule_state_updated_version) FROM stdin;
\.


--
-- Data for Name: alert_rule; Type: TABLE DATA; Schema: public; Owner: grafana
--

COPY public.alert_rule (id, org_id, title, condition, data, updated, interval_seconds, version, uid, namespace_uid,
                        rule_group, no_data_state, exec_err_state, "for", annotations, labels, dashboard_uid, panel_id,
                        rule_group_idx, is_paused, notification_settings) FROM stdin;
\.


--
-- Data for Name: alert_rule_tag; Type: TABLE DATA; Schema: public; Owner: grafana
--

COPY public.alert_rule_tag (id, alert_id, tag_id) FROM stdin;
\.


--
-- Data for Name: alert_rule_version; Type: TABLE DATA; Schema: public; Owner: grafana
--

COPY public.alert_rule_version (id, rule_org_id, rule_uid, rule_namespace_uid, rule_group, parent_version,
                                restored_from, version, created, title, condition, data, interval_seconds,
                                no_data_state, exec_err_state, "for", annotations, labels, rule_group_idx, is_paused,
                                notification_settings) FROM stdin;
\.


--
-- Data for Name: annotation; Type: TABLE DATA; Schema: public; Owner: grafana
--

COPY public.annotation (id, org_id, alert_id, user_id, dashboard_id, panel_id, category_id, type, title, text, metric,
                        prev_state, new_state, data, epoch, region_id, tags, created, updated, epoch_end) FROM stdin;
\.


--
-- Data for Name: annotation_tag; Type: TABLE DATA; Schema: public; Owner: grafana
--

COPY public.annotation_tag (id, annotation_id, tag_id) FROM stdin;
\.


--
-- Data for Name: anon_device; Type: TABLE DATA; Schema: public; Owner: grafana
--

COPY public.anon_device (id, client_ip, created_at, device_id, updated_at, user_agent) FROM stdin;
\.


--
-- Data for Name: api_key; Type: TABLE DATA; Schema: public; Owner: grafana
--

COPY public.api_key (id, org_id, name, key, role, created, updated, expires, service_account_id, last_used_at,
                     is_revoked) FROM stdin;
\.


--
-- Data for Name: builtin_role; Type: TABLE DATA; Schema: public; Owner: grafana
--

COPY public.builtin_role (id, role, role_id, created, updated, org_id) FROM stdin;
\.


--
-- Data for Name: cache_data; Type: TABLE DATA; Schema: public; Owner: grafana
--

COPY public.cache_data (cache_key, data, expires, created_at) FROM stdin;
\.


--
-- Data for Name: correlation; Type: TABLE DATA; Schema: public; Owner: grafana
--

COPY public.correlation (uid, org_id, source_uid, target_uid, label, description, config, provisioned) FROM stdin;
\.


--
-- Data for Name: dashboard; Type: TABLE DATA; Schema: public; Owner: grafana
--

COPY public.dashboard (id, version, slug, title, data, org_id, created, updated, updated_by, created_by, gnet_id,
                       plugin_id, folder_id, is_folder, has_acl, uid, is_public, folder_uid) FROM stdin;
\.


--
-- Data for Name: dashboard_acl; Type: TABLE DATA; Schema: public; Owner: grafana
--

COPY public.dashboard_acl (id, org_id, dashboard_id, user_id, team_id, permission, role, created, updated) FROM stdin;
1	-1	-1	\N	\N	1	Viewer	2017-06-20 00:00:00	2017-06-20 00:00:00
2	-1	-1	\N	\N	2	Editor	2017-06-20 00:00:00	2017-06-20 00:00:00
\.


--
-- Data for Name: dashboard_provisioning; Type: TABLE DATA; Schema: public; Owner: grafana
--

COPY public.dashboard_provisioning (id, dashboard_id, name, external_id, updated, check_sum) FROM stdin;
\.


--
-- Data for Name: dashboard_public; Type: TABLE DATA; Schema: public; Owner: grafana
--

COPY public.dashboard_public (uid, dashboard_uid, org_id, time_settings, template_variables, access_token, created_by,
                              updated_by, created_at, updated_at, is_enabled, annotations_enabled,
                              time_selection_enabled, share) FROM stdin;
\.


--
-- Data for Name: dashboard_snapshot; Type: TABLE DATA; Schema: public; Owner: grafana
--

COPY public.dashboard_snapshot (id, name, key, delete_key, org_id, user_id, external, external_url, dashboard, expires,
                                created, updated, external_delete_url, dashboard_encrypted) FROM stdin;
\.


--
-- Data for Name: dashboard_tag; Type: TABLE DATA; Schema: public; Owner: grafana
--

COPY public.dashboard_tag (id, dashboard_id, term) FROM stdin;
\.


--
-- Data for Name: dashboard_version; Type: TABLE DATA; Schema: public; Owner: grafana
--

COPY public.dashboard_version (id, dashboard_id, parent_version, restored_from, version, created, created_by, message,
                               data) FROM stdin;
\.


--
-- Data for Name: data_keys; Type: TABLE DATA; Schema: public; Owner: grafana
--

COPY public.data_keys (name, active, scope, provider, encrypted_data, created, updated, label) FROM stdin;
\.


--
-- Data for Name: data_source; Type: TABLE DATA; Schema: public; Owner: grafana
--

COPY public.data_source (id, org_id, version, type, name, access, url, password, "user", database, basic_auth,
                         basic_auth_user, basic_auth_password, is_default, json_data, created, updated,
                         with_credentials, secure_json_data, read_only, uid) FROM stdin;
\.


--
-- Data for Name: entity_event; Type: TABLE DATA; Schema: public; Owner: grafana
--

COPY public.entity_event (id, entity_id, event_type, created) FROM stdin;
\.


--
-- Data for Name: file; Type: TABLE DATA; Schema: public; Owner: grafana
--

COPY public.file (path, path_hash, parent_folder_path_hash, contents, etag, cache_control, content_disposition, updated,
                  created, size, mime_type) FROM stdin;
\.


--
-- Data for Name: file_meta; Type: TABLE DATA; Schema: public; Owner: grafana
--

COPY public.file_meta (path_hash, key, value) FROM stdin;
\.


--
-- Data for Name: folder; Type: TABLE DATA; Schema: public; Owner: grafana
--

COPY public.folder (id, uid, org_id, title, description, parent_uid, created, updated) FROM stdin;
\.


--
-- Data for Name: kv_store; Type: TABLE DATA; Schema: public; Owner: grafana
--

COPY public.kv_store (id, org_id, namespace, key, value, created, updated) FROM stdin;
2	1	ngalert.migration	stateKey	{"orgId":1,"migratedDashboards":{},"migratedChannels":{},"createdFolders":null}	2024-03-25 14:20:20	2024-03-25 14:20:20
3	1	ngalert.migration	migrated	true	2024-03-25 14:20:20	2024-03-25 14:20:20
1	0	ngalert.migration	currentAlertingType	UnifiedAlerting	2024-03-25 14:20:20	2024-03-25 14:20:20.462998
4	0	datasource	secretMigrationStatus	compatible	2024-03-25 14:20:20	2024-03-25 14:20:20
5	0	plugin.publickeys	key-7e4d0c6a708866e7	-----BEGIN PGP PUBLIC KEY BLOCK-----\r\nVersion: OpenPGP.js v4.10.1\r\nComment: https://openpgpjs.org\r\n\r\nxpMEXpTXXxMFK4EEACMEIwQBiOUQhvGbDLvndE0fEXaR0908wXzPGFpf0P0Z\r\nHJ06tsq+0higIYHp7WTNJVEZtcwoYLcPRGaa9OQqbUU63BEyZdgAkPTz3RFd\r\n5+TkDWZizDcaVFhzbDd500yTwexrpIrdInwC/jrgs7Zy/15h8KA59XXUkdmT\r\nYB6TR+OA9RKME+dCJozNGUdyYWZhbmEgPGVuZ0BncmFmYW5hLmNvbT7CvAQQ\r\nEwoAIAUCXpTXXwYLCQcIAwIEFQgKAgQWAgEAAhkBAhsDAh4BAAoJEH5NDGpw\r\niGbnaWoCCQGQ3SQnCkRWrG6XrMkXOKfDTX2ow9fuoErN46BeKmLM4f1EkDZQ\r\nTpq3SE8+My8B5BIH3SOcBeKzi3S57JHGBdFA+wIJAYWMrJNIvw8GeXne+oUo\r\nNzzACdvfqXAZEp/HFMQhCKfEoWGJE8d2YmwY2+3GufVRTI5lQnZOHLE8L/Vc\r\n1S5MXESjzpcEXpTXXxIFK4EEACMEIwQBtHX/SD5Qm3v4V92qpaIZQgtTX0sT\r\ncFPjYWAHqsQ1iENrYN/vg1wU3ADlYATvydOQYvkTyT/tbDvx2Fse8PL84MQA\r\nYKKQ6AJ3gLVvmeouZdU03YoV4MYaT8KbnJUkZQZkqdz2riOlySNI9CG3oYmv\r\nomjUAtzgAgnCcurfGLZkkMxlmY8DAQoJwqQEGBMKAAkFAl6U118CGwwACgkQ\r\nfk0ManCIZuc0jAIJAVw2xdLr4ZQqPUhubrUyFcqlWoW8dQoQagwO8s8ubmby\r\nKuLA9FWJkfuuRQr+O9gHkDVCez3aism7zmJBqIOi38aNAgjJ3bo6leSS2jR/\r\nx5NqiKVi83tiXDPncDQYPymOnMhW0l7CVA7wj75HrFvvlRI/4MArlbsZ2tBn\r\nN1c5v9v/4h6qeA==\r\n=DNbR\r\n-----END PGP PUBLIC KEY BLOCK-----\r\n	2024-03-25 14:20:20	2024-03-25 14:20:20
6	0	plugin.publickeys	last_updated	2024-03-25T14:20:20Z	2024-03-25 14:20:20	2024-03-25 14:20:20
7	1	alertmanager	notifications		2024-03-25 15:00:22	2024-03-25 15:00:22
8	1	alertmanager	silences		2024-03-25 15:00:22	2024-03-25 15:00:22
\.


--
-- Data for Name: library_element; Type: TABLE DATA; Schema: public; Owner: grafana
--

COPY public.library_element (id, org_id, folder_id, uid, name, kind, type, description, model, created, created_by,
                             updated, updated_by, version) FROM stdin;
\.


--
-- Data for Name: library_element_connection; Type: TABLE DATA; Schema: public; Owner: grafana
--

COPY public.library_element_connection (id, element_id, kind, connection_id, created, created_by) FROM stdin;
\.


--
-- Data for Name: login_attempt; Type: TABLE DATA; Schema: public; Owner: grafana
--

COPY public.login_attempt (id, username, ip_address, created) FROM stdin;
\.


--
-- Data for Name: migration_log; Type: TABLE DATA; Schema: public; Owner: grafana
--

COPY public.migration_log (id, migration_id, sql, success, error, "timestamp") FROM stdin;
1	create migration_log table	CREATE TABLE IF NOT EXISTS "migration_log" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "migration_id" VARCHAR(255) NOT NULL\n, "sql" TEXT NOT NULL\n, "success" BOOL NOT NULL\n, "error" TEXT NOT NULL\n, "timestamp" TIMESTAMP NOT NULL\n);	t		2024-03-25 14:20:19
2	create user table	CREATE TABLE IF NOT EXISTS "user" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "version" INTEGER NOT NULL\n, "login" VARCHAR(190) NOT NULL\n, "email" VARCHAR(190) NOT NULL\n, "name" VARCHAR(255) NULL\n, "password" VARCHAR(255) NULL\n, "salt" VARCHAR(50) NULL\n, "rands" VARCHAR(50) NULL\n, "company" VARCHAR(255) NULL\n, "account_id" BIGINT NOT NULL\n, "is_admin" BOOL NOT NULL\n, "created" TIMESTAMP NOT NULL\n, "updated" TIMESTAMP NOT NULL\n);	t		2024-03-25 14:20:19
3	add unique index user.login	CREATE UNIQUE INDEX "UQE_user_login" ON "user" ("login");	t		2024-03-25 14:20:19
4	add unique index user.email	CREATE UNIQUE INDEX "UQE_user_email" ON "user" ("email");	t		2024-03-25 14:20:19
5	drop index UQE_user_login - v1	DROP INDEX "UQE_user_login" CASCADE	t		2024-03-25 14:20:19
6	drop index UQE_user_email - v1	DROP INDEX "UQE_user_email" CASCADE	t		2024-03-25 14:20:19
7	Rename table user to user_v1 - v1	ALTER TABLE "user" RENAME TO "user_v1"	t		2024-03-25 14:20:19
8	create user table v2	CREATE TABLE IF NOT EXISTS "user" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "version" INTEGER NOT NULL\n, "login" VARCHAR(190) NOT NULL\n, "email" VARCHAR(190) NOT NULL\n, "name" VARCHAR(255) NULL\n, "password" VARCHAR(255) NULL\n, "salt" VARCHAR(50) NULL\n, "rands" VARCHAR(50) NULL\n, "company" VARCHAR(255) NULL\n, "org_id" BIGINT NOT NULL\n, "is_admin" BOOL NOT NULL\n, "email_verified" BOOL NULL\n, "theme" VARCHAR(255) NULL\n, "created" TIMESTAMP NOT NULL\n, "updated" TIMESTAMP NOT NULL\n);	t		2024-03-25 14:20:19
9	create index UQE_user_login - v2	CREATE UNIQUE INDEX "UQE_user_login" ON "user" ("login");	t		2024-03-25 14:20:19
10	create index UQE_user_email - v2	CREATE UNIQUE INDEX "UQE_user_email" ON "user" ("email");	t		2024-03-25 14:20:19
11	copy data_source v1 to v2	INSERT INTO "user" ("company"\n, "org_id"\n, "version"\n, "email"\n, "password"\n, "created"\n, "login"\n, "salt"\n, "is_admin"\n, "id"\n, "name"\n, "rands"\n, "updated") SELECT "company"\n, "account_id"\n, "version"\n, "email"\n, "password"\n, "created"\n, "login"\n, "salt"\n, "is_admin"\n, "id"\n, "name"\n, "rands"\n, "updated" FROM "user_v1"	t		2024-03-25 14:20:19
12	Drop old table user_v1	DROP TABLE IF EXISTS "user_v1"	t		2024-03-25 14:20:19
13	Add column help_flags1 to user table	alter table "user" ADD COLUMN "help_flags1" BIGINT NOT NULL DEFAULT 0 	t		2024-03-25 14:20:19
14	Update user table charset	ALTER TABLE "user" ALTER "login" TYPE VARCHAR(190), ALTER "email" TYPE VARCHAR(190), ALTER "name" TYPE VARCHAR(255), ALTER "password" TYPE VARCHAR(255), ALTER "salt" TYPE VARCHAR(50), ALTER "rands" TYPE VARCHAR(50), ALTER "company" TYPE VARCHAR(255), ALTER "theme" TYPE VARCHAR(255);	t		2024-03-25 14:20:19
15	Add last_seen_at column to user	alter table "user" ADD COLUMN "last_seen_at" TIMESTAMP NULL 	t		2024-03-25 14:20:19
16	Add missing user data	code migration	t		2024-03-25 14:20:19
17	Add is_disabled column to user	alter table "user" ADD COLUMN "is_disabled" BOOL NOT NULL DEFAULT false 	t		2024-03-25 14:20:19
18	Add index user.login/user.email	CREATE INDEX "IDX_user_login_email" ON "user" ("login","email");	t		2024-03-25 14:20:19
19	Add is_service_account column to user	alter table "user" ADD COLUMN "is_service_account" BOOL NOT NULL DEFAULT false 	t		2024-03-25 14:20:19
20	Update is_service_account column to nullable	ALTER TABLE `user` ALTER COLUMN is_service_account DROP NOT NULL;	t		2024-03-25 14:20:19
21	Add uid column to user	alter table "user" ADD COLUMN "uid" VARCHAR(40) NULL 	t		2024-03-25 14:20:19
22	Update uid column values for users	UPDATE `user` SET uid='u' || lpad('' || id::text,9,'0') WHERE uid IS NULL;	t		2024-03-25 14:20:19
23	Add unique index user_uid	CREATE UNIQUE INDEX "UQE_user_uid" ON "user" ("uid");	t		2024-03-25 14:20:19
24	update login field with orgid to allow for multiple service accounts with same name across orgs	code migration	t		2024-03-25 14:20:19
25	create temp user table v1-7	CREATE TABLE IF NOT EXISTS "temp_user" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "org_id" BIGINT NOT NULL\n, "version" INTEGER NOT NULL\n, "email" VARCHAR(190) NOT NULL\n, "name" VARCHAR(255) NULL\n, "role" VARCHAR(20) NULL\n, "code" VARCHAR(190) NOT NULL\n, "status" VARCHAR(20) NOT NULL\n, "invited_by_user_id" BIGINT NULL\n, "email_sent" BOOL NOT NULL\n, "email_sent_on" TIMESTAMP NULL\n, "remote_addr" VARCHAR(255) NULL\n, "created" TIMESTAMP NOT NULL\n, "updated" TIMESTAMP NOT NULL\n);	t		2024-03-25 14:20:19
26	create index IDX_temp_user_email - v1-7	CREATE INDEX "IDX_temp_user_email" ON "temp_user" ("email");	t		2024-03-25 14:20:19
27	create index IDX_temp_user_org_id - v1-7	CREATE INDEX "IDX_temp_user_org_id" ON "temp_user" ("org_id");	t		2024-03-25 14:20:19
28	create index IDX_temp_user_code - v1-7	CREATE INDEX "IDX_temp_user_code" ON "temp_user" ("code");	t		2024-03-25 14:20:19
29	create index IDX_temp_user_status - v1-7	CREATE INDEX "IDX_temp_user_status" ON "temp_user" ("status");	t		2024-03-25 14:20:19
30	Update temp_user table charset	ALTER TABLE "temp_user" ALTER "email" TYPE VARCHAR(190), ALTER "name" TYPE VARCHAR(255), ALTER "role" TYPE VARCHAR(20), ALTER "code" TYPE VARCHAR(190), ALTER "status" TYPE VARCHAR(20), ALTER "remote_addr" TYPE VARCHAR(255);	t		2024-03-25 14:20:19
31	drop index IDX_temp_user_email - v1	DROP INDEX "IDX_temp_user_email" CASCADE	t		2024-03-25 14:20:19
32	drop index IDX_temp_user_org_id - v1	DROP INDEX "IDX_temp_user_org_id" CASCADE	t		2024-03-25 14:20:19
33	drop index IDX_temp_user_code - v1	DROP INDEX "IDX_temp_user_code" CASCADE	t		2024-03-25 14:20:19
34	drop index IDX_temp_user_status - v1	DROP INDEX "IDX_temp_user_status" CASCADE	t		2024-03-25 14:20:19
35	Rename table temp_user to temp_user_tmp_qwerty - v1	ALTER TABLE "temp_user" RENAME TO "temp_user_tmp_qwerty"	t		2024-03-25 14:20:19
36	create temp_user v2	CREATE TABLE IF NOT EXISTS "temp_user" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "org_id" BIGINT NOT NULL\n, "version" INTEGER NOT NULL\n, "email" VARCHAR(190) NOT NULL\n, "name" VARCHAR(255) NULL\n, "role" VARCHAR(20) NULL\n, "code" VARCHAR(190) NOT NULL\n, "status" VARCHAR(20) NOT NULL\n, "invited_by_user_id" BIGINT NULL\n, "email_sent" BOOL NOT NULL\n, "email_sent_on" TIMESTAMP NULL\n, "remote_addr" VARCHAR(255) NULL\n, "created" INTEGER NOT NULL DEFAULT 0\n, "updated" INTEGER NOT NULL DEFAULT 0\n);	t		2024-03-25 14:20:19
37	create index IDX_temp_user_email - v2	CREATE INDEX "IDX_temp_user_email" ON "temp_user" ("email");	t		2024-03-25 14:20:19
38	create index IDX_temp_user_org_id - v2	CREATE INDEX "IDX_temp_user_org_id" ON "temp_user" ("org_id");	t		2024-03-25 14:20:19
39	create index IDX_temp_user_code - v2	CREATE INDEX "IDX_temp_user_code" ON "temp_user" ("code");	t		2024-03-25 14:20:19
40	create index IDX_temp_user_status - v2	CREATE INDEX "IDX_temp_user_status" ON "temp_user" ("status");	t		2024-03-25 14:20:19
84	Update dashboard title length	ALTER TABLE "dashboard" ALTER "title" TYPE VARCHAR(189);	t		2024-03-25 14:20:19
125	drop index UQE_api_key_key - v1	DROP INDEX "UQE_api_key_key" CASCADE	t		2024-03-25 14:20:19
41	copy temp_user v1 to v2	INSERT INTO "temp_user" ("role"\n, "email_sent"\n, "remote_addr"\n, "org_id"\n, "email"\n, "name"\n, "code"\n, "status"\n, "invited_by_user_id"\n, "email_sent_on"\n, "id"\n, "version") SELECT "role"\n, "email_sent"\n, "remote_addr"\n, "org_id"\n, "email"\n, "name"\n, "code"\n, "status"\n, "invited_by_user_id"\n, "email_sent_on"\n, "id"\n, "version" FROM "temp_user_tmp_qwerty"	t		2024-03-25 14:20:19
42	drop temp_user_tmp_qwerty	DROP TABLE IF EXISTS "temp_user_tmp_qwerty"	t		2024-03-25 14:20:19
43	Set created for temp users that will otherwise prematurely expire	code migration	t		2024-03-25 14:20:19
44	create star table	CREATE TABLE IF NOT EXISTS "star" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "user_id" BIGINT NOT NULL\n, "dashboard_id" BIGINT NOT NULL\n);	t		2024-03-25 14:20:19
45	add unique index star.user_id_dashboard_id	CREATE UNIQUE INDEX "UQE_star_user_id_dashboard_id" ON "star" ("user_id","dashboard_id");	t		2024-03-25 14:20:19
46	create org table v1	CREATE TABLE IF NOT EXISTS "org" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "version" INTEGER NOT NULL\n, "name" VARCHAR(190) NOT NULL\n, "address1" VARCHAR(255) NULL\n, "address2" VARCHAR(255) NULL\n, "city" VARCHAR(255) NULL\n, "state" VARCHAR(255) NULL\n, "zip_code" VARCHAR(50) NULL\n, "country" VARCHAR(255) NULL\n, "billing_email" VARCHAR(255) NULL\n, "created" TIMESTAMP NOT NULL\n, "updated" TIMESTAMP NOT NULL\n);	t		2024-03-25 14:20:19
47	create index UQE_org_name - v1	CREATE UNIQUE INDEX "UQE_org_name" ON "org" ("name");	t		2024-03-25 14:20:19
48	create org_user table v1	CREATE TABLE IF NOT EXISTS "org_user" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "org_id" BIGINT NOT NULL\n, "user_id" BIGINT NOT NULL\n, "role" VARCHAR(20) NOT NULL\n, "created" TIMESTAMP NOT NULL\n, "updated" TIMESTAMP NOT NULL\n);	t		2024-03-25 14:20:19
49	create index IDX_org_user_org_id - v1	CREATE INDEX "IDX_org_user_org_id" ON "org_user" ("org_id");	t		2024-03-25 14:20:19
50	create index UQE_org_user_org_id_user_id - v1	CREATE UNIQUE INDEX "UQE_org_user_org_id_user_id" ON "org_user" ("org_id","user_id");	t		2024-03-25 14:20:19
51	create index IDX_org_user_user_id - v1	CREATE INDEX "IDX_org_user_user_id" ON "org_user" ("user_id");	t		2024-03-25 14:20:19
52	Update org table charset	ALTER TABLE "org" ALTER "name" TYPE VARCHAR(190), ALTER "address1" TYPE VARCHAR(255), ALTER "address2" TYPE VARCHAR(255), ALTER "city" TYPE VARCHAR(255), ALTER "state" TYPE VARCHAR(255), ALTER "zip_code" TYPE VARCHAR(50), ALTER "country" TYPE VARCHAR(255), ALTER "billing_email" TYPE VARCHAR(255);	t		2024-03-25 14:20:19
53	Update org_user table charset	ALTER TABLE "org_user" ALTER "role" TYPE VARCHAR(20);	t		2024-03-25 14:20:19
54	Migrate all Read Only Viewers to Viewers	UPDATE org_user SET role = 'Viewer' WHERE role = 'Read Only Editor'	t		2024-03-25 14:20:19
55	create dashboard table	CREATE TABLE IF NOT EXISTS "dashboard" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "version" INTEGER NOT NULL\n, "slug" VARCHAR(189) NOT NULL\n, "title" VARCHAR(255) NOT NULL\n, "data" TEXT NOT NULL\n, "account_id" BIGINT NOT NULL\n, "created" TIMESTAMP NOT NULL\n, "updated" TIMESTAMP NOT NULL\n);	t		2024-03-25 14:20:19
56	add index dashboard.account_id	CREATE INDEX "IDX_dashboard_account_id" ON "dashboard" ("account_id");	t		2024-03-25 14:20:19
57	add unique index dashboard_account_id_slug	CREATE UNIQUE INDEX "UQE_dashboard_account_id_slug" ON "dashboard" ("account_id","slug");	t		2024-03-25 14:20:19
58	create dashboard_tag table	CREATE TABLE IF NOT EXISTS "dashboard_tag" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "dashboard_id" BIGINT NOT NULL\n, "term" VARCHAR(50) NOT NULL\n);	t		2024-03-25 14:20:19
59	add unique index dashboard_tag.dasboard_id_term	CREATE UNIQUE INDEX "UQE_dashboard_tag_dashboard_id_term" ON "dashboard_tag" ("dashboard_id","term");	t		2024-03-25 14:20:19
60	drop index UQE_dashboard_tag_dashboard_id_term - v1	DROP INDEX "UQE_dashboard_tag_dashboard_id_term" CASCADE	t		2024-03-25 14:20:19
61	Rename table dashboard to dashboard_v1 - v1	ALTER TABLE "dashboard" RENAME TO "dashboard_v1"	t		2024-03-25 14:20:19
62	create dashboard v2	CREATE TABLE IF NOT EXISTS "dashboard" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "version" INTEGER NOT NULL\n, "slug" VARCHAR(189) NOT NULL\n, "title" VARCHAR(255) NOT NULL\n, "data" TEXT NOT NULL\n, "org_id" BIGINT NOT NULL\n, "created" TIMESTAMP NOT NULL\n, "updated" TIMESTAMP NOT NULL\n);	t		2024-03-25 14:20:19
63	create index IDX_dashboard_org_id - v2	CREATE INDEX "IDX_dashboard_org_id" ON "dashboard" ("org_id");	t		2024-03-25 14:20:19
64	create index UQE_dashboard_org_id_slug - v2	CREATE UNIQUE INDEX "UQE_dashboard_org_id_slug" ON "dashboard" ("org_id","slug");	t		2024-03-25 14:20:19
65	copy dashboard v1 to v2	INSERT INTO "dashboard" ("created"\n, "updated"\n, "id"\n, "version"\n, "slug"\n, "title"\n, "data"\n, "org_id") SELECT "created"\n, "updated"\n, "id"\n, "version"\n, "slug"\n, "title"\n, "data"\n, "account_id" FROM "dashboard_v1"	t		2024-03-25 14:20:19
66	drop table dashboard_v1	DROP TABLE IF EXISTS "dashboard_v1"	t		2024-03-25 14:20:19
67	alter dashboard.data to mediumtext v1	SELECT 0;	t		2024-03-25 14:20:19
68	Add column updated_by in dashboard - v2	alter table "dashboard" ADD COLUMN "updated_by" INTEGER NULL 	t		2024-03-25 14:20:19
69	Add column created_by in dashboard - v2	alter table "dashboard" ADD COLUMN "created_by" INTEGER NULL 	t		2024-03-25 14:20:19
70	Add column gnetId in dashboard	alter table "dashboard" ADD COLUMN "gnet_id" BIGINT NULL 	t		2024-03-25 14:20:19
71	Add index for gnetId in dashboard	CREATE INDEX "IDX_dashboard_gnet_id" ON "dashboard" ("gnet_id");	t		2024-03-25 14:20:19
72	Add column plugin_id in dashboard	alter table "dashboard" ADD COLUMN "plugin_id" VARCHAR(189) NULL 	t		2024-03-25 14:20:19
73	Add index for plugin_id in dashboard	CREATE INDEX "IDX_dashboard_org_id_plugin_id" ON "dashboard" ("org_id","plugin_id");	t		2024-03-25 14:20:19
74	Add index for dashboard_id in dashboard_tag	CREATE INDEX "IDX_dashboard_tag_dashboard_id" ON "dashboard_tag" ("dashboard_id");	t		2024-03-25 14:20:19
75	Update dashboard table charset	ALTER TABLE "dashboard" ALTER "slug" TYPE VARCHAR(189), ALTER "title" TYPE VARCHAR(255), ALTER "plugin_id" TYPE VARCHAR(189), ALTER "data" TYPE TEXT;	t		2024-03-25 14:20:19
76	Update dashboard_tag table charset	ALTER TABLE "dashboard_tag" ALTER "term" TYPE VARCHAR(50);	t		2024-03-25 14:20:19
77	Add column folder_id in dashboard	alter table "dashboard" ADD COLUMN "folder_id" BIGINT NOT NULL DEFAULT 0 	t		2024-03-25 14:20:19
78	Add column isFolder in dashboard	alter table "dashboard" ADD COLUMN "is_folder" BOOL NOT NULL DEFAULT false 	t		2024-03-25 14:20:19
79	Add column has_acl in dashboard	alter table "dashboard" ADD COLUMN "has_acl" BOOL NOT NULL DEFAULT false 	t		2024-03-25 14:20:19
80	Add column uid in dashboard	alter table "dashboard" ADD COLUMN "uid" VARCHAR(40) NULL 	t		2024-03-25 14:20:19
81	Update uid column values in dashboard	UPDATE dashboard SET uid=lpad('' || id::text,9,'0') WHERE uid IS NULL;	t		2024-03-25 14:20:19
82	Add unique index dashboard_org_id_uid	CREATE UNIQUE INDEX "UQE_dashboard_org_id_uid" ON "dashboard" ("org_id","uid");	t		2024-03-25 14:20:19
83	Remove unique index org_id_slug	DROP INDEX "UQE_dashboard_org_id_slug" CASCADE	t		2024-03-25 14:20:19
85	Add unique index for dashboard_org_id_title_folder_id	CREATE UNIQUE INDEX "UQE_dashboard_org_id_folder_id_title" ON "dashboard" ("org_id","folder_id","title");	t		2024-03-25 14:20:19
86	create dashboard_provisioning	CREATE TABLE IF NOT EXISTS "dashboard_provisioning" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "dashboard_id" BIGINT NULL\n, "name" VARCHAR(150) NOT NULL\n, "external_id" TEXT NOT NULL\n, "updated" TIMESTAMP NOT NULL\n);	t		2024-03-25 14:20:19
87	Rename table dashboard_provisioning to dashboard_provisioning_tmp_qwerty - v1	ALTER TABLE "dashboard_provisioning" RENAME TO "dashboard_provisioning_tmp_qwerty"	t		2024-03-25 14:20:19
88	create dashboard_provisioning v2	CREATE TABLE IF NOT EXISTS "dashboard_provisioning" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "dashboard_id" BIGINT NULL\n, "name" VARCHAR(150) NOT NULL\n, "external_id" TEXT NOT NULL\n, "updated" INTEGER NOT NULL DEFAULT 0\n);	t		2024-03-25 14:20:19
89	create index IDX_dashboard_provisioning_dashboard_id - v2	CREATE INDEX "IDX_dashboard_provisioning_dashboard_id" ON "dashboard_provisioning" ("dashboard_id");	t		2024-03-25 14:20:19
90	create index IDX_dashboard_provisioning_dashboard_id_name - v2	CREATE INDEX "IDX_dashboard_provisioning_dashboard_id_name" ON "dashboard_provisioning" ("dashboard_id","name");	t		2024-03-25 14:20:19
91	copy dashboard_provisioning v1 to v2	INSERT INTO "dashboard_provisioning" ("name"\n, "external_id"\n, "id"\n, "dashboard_id") SELECT "name"\n, "external_id"\n, "id"\n, "dashboard_id" FROM "dashboard_provisioning_tmp_qwerty"	t		2024-03-25 14:20:19
92	drop dashboard_provisioning_tmp_qwerty	DROP TABLE IF EXISTS "dashboard_provisioning_tmp_qwerty"	t		2024-03-25 14:20:19
93	Add check_sum column	alter table "dashboard_provisioning" ADD COLUMN "check_sum" VARCHAR(32) NULL 	t		2024-03-25 14:20:19
94	Add index for dashboard_title	CREATE INDEX "IDX_dashboard_title" ON "dashboard" ("title");	t		2024-03-25 14:20:19
95	delete tags for deleted dashboards	DELETE FROM dashboard_tag WHERE dashboard_id NOT IN (SELECT id FROM dashboard)	t		2024-03-25 14:20:19
96	delete stars for deleted dashboards	DELETE FROM star WHERE dashboard_id NOT IN (SELECT id FROM dashboard)	t		2024-03-25 14:20:19
97	Add index for dashboard_is_folder	CREATE INDEX "IDX_dashboard_is_folder" ON "dashboard" ("is_folder");	t		2024-03-25 14:20:19
98	Add isPublic for dashboard	alter table "dashboard" ADD COLUMN "is_public" BOOL NOT NULL DEFAULT false 	t		2024-03-25 14:20:19
99	create data_source table	CREATE TABLE IF NOT EXISTS "data_source" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "account_id" BIGINT NOT NULL\n, "version" INTEGER NOT NULL\n, "type" VARCHAR(255) NOT NULL\n, "name" VARCHAR(190) NOT NULL\n, "access" VARCHAR(255) NOT NULL\n, "url" VARCHAR(255) NOT NULL\n, "password" VARCHAR(255) NULL\n, "user" VARCHAR(255) NULL\n, "database" VARCHAR(255) NULL\n, "basic_auth" BOOL NOT NULL\n, "basic_auth_user" VARCHAR(255) NULL\n, "basic_auth_password" VARCHAR(255) NULL\n, "is_default" BOOL NOT NULL\n, "created" TIMESTAMP NOT NULL\n, "updated" TIMESTAMP NOT NULL\n);	t		2024-03-25 14:20:19
100	add index data_source.account_id	CREATE INDEX "IDX_data_source_account_id" ON "data_source" ("account_id");	t		2024-03-25 14:20:19
101	add unique index data_source.account_id_name	CREATE UNIQUE INDEX "UQE_data_source_account_id_name" ON "data_source" ("account_id","name");	t		2024-03-25 14:20:19
102	drop index IDX_data_source_account_id - v1	DROP INDEX "IDX_data_source_account_id" CASCADE	t		2024-03-25 14:20:19
103	drop index UQE_data_source_account_id_name - v1	DROP INDEX "UQE_data_source_account_id_name" CASCADE	t		2024-03-25 14:20:19
104	Rename table data_source to data_source_v1 - v1	ALTER TABLE "data_source" RENAME TO "data_source_v1"	t		2024-03-25 14:20:19
105	create data_source table v2	CREATE TABLE IF NOT EXISTS "data_source" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "org_id" BIGINT NOT NULL\n, "version" INTEGER NOT NULL\n, "type" VARCHAR(255) NOT NULL\n, "name" VARCHAR(190) NOT NULL\n, "access" VARCHAR(255) NOT NULL\n, "url" VARCHAR(255) NOT NULL\n, "password" VARCHAR(255) NULL\n, "user" VARCHAR(255) NULL\n, "database" VARCHAR(255) NULL\n, "basic_auth" BOOL NOT NULL\n, "basic_auth_user" VARCHAR(255) NULL\n, "basic_auth_password" VARCHAR(255) NULL\n, "is_default" BOOL NOT NULL\n, "json_data" TEXT NULL\n, "created" TIMESTAMP NOT NULL\n, "updated" TIMESTAMP NOT NULL\n);	t		2024-03-25 14:20:19
106	create index IDX_data_source_org_id - v2	CREATE INDEX "IDX_data_source_org_id" ON "data_source" ("org_id");	t		2024-03-25 14:20:19
107	create index UQE_data_source_org_id_name - v2	CREATE UNIQUE INDEX "UQE_data_source_org_id_name" ON "data_source" ("org_id","name");	t		2024-03-25 14:20:19
108	Drop old table data_source_v1 #2	DROP TABLE IF EXISTS "data_source_v1"	t		2024-03-25 14:20:19
109	Add column with_credentials	alter table "data_source" ADD COLUMN "with_credentials" BOOL NOT NULL DEFAULT false 	t		2024-03-25 14:20:19
110	Add secure json data column	alter table "data_source" ADD COLUMN "secure_json_data" TEXT NULL 	t		2024-03-25 14:20:19
111	Update data_source table charset	ALTER TABLE "data_source" ALTER "type" TYPE VARCHAR(255), ALTER "name" TYPE VARCHAR(190), ALTER "access" TYPE VARCHAR(255), ALTER "url" TYPE VARCHAR(255), ALTER "password" TYPE VARCHAR(255), ALTER "user" TYPE VARCHAR(255), ALTER "database" TYPE VARCHAR(255), ALTER "basic_auth_user" TYPE VARCHAR(255), ALTER "basic_auth_password" TYPE VARCHAR(255), ALTER "json_data" TYPE TEXT, ALTER "secure_json_data" TYPE TEXT;	t		2024-03-25 14:20:19
112	Update initial version to 1	UPDATE data_source SET version = 1 WHERE version = 0	t		2024-03-25 14:20:19
113	Add read_only data column	alter table "data_source" ADD COLUMN "read_only" BOOL NULL 	t		2024-03-25 14:20:19
114	Migrate logging ds to loki ds	UPDATE data_source SET type = 'loki' WHERE type = 'logging'	t		2024-03-25 14:20:19
115	Update json_data with nulls	UPDATE data_source SET json_data = '{}' WHERE json_data is null	t		2024-03-25 14:20:19
116	Add uid column	alter table "data_source" ADD COLUMN "uid" VARCHAR(40) NOT NULL DEFAULT 0 	t		2024-03-25 14:20:19
117	Update uid value	UPDATE data_source SET uid=lpad('' || id::text,9,'0');	t		2024-03-25 14:20:19
118	Add unique index datasource_org_id_uid	CREATE UNIQUE INDEX "UQE_data_source_org_id_uid" ON "data_source" ("org_id","uid");	t		2024-03-25 14:20:19
119	add unique index datasource_org_id_is_default	CREATE INDEX "IDX_data_source_org_id_is_default" ON "data_source" ("org_id","is_default");	t		2024-03-25 14:20:19
120	create api_key table	CREATE TABLE IF NOT EXISTS "api_key" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "account_id" BIGINT NOT NULL\n, "name" VARCHAR(190) NOT NULL\n, "key" VARCHAR(64) NOT NULL\n, "role" VARCHAR(255) NOT NULL\n, "created" TIMESTAMP NOT NULL\n, "updated" TIMESTAMP NOT NULL\n);	t		2024-03-25 14:20:19
121	add index api_key.account_id	CREATE INDEX "IDX_api_key_account_id" ON "api_key" ("account_id");	t		2024-03-25 14:20:19
122	add index api_key.key	CREATE UNIQUE INDEX "UQE_api_key_key" ON "api_key" ("key");	t		2024-03-25 14:20:19
123	add index api_key.account_id_name	CREATE UNIQUE INDEX "UQE_api_key_account_id_name" ON "api_key" ("account_id","name");	t		2024-03-25 14:20:19
124	drop index IDX_api_key_account_id - v1	DROP INDEX "IDX_api_key_account_id" CASCADE	t		2024-03-25 14:20:19
126	drop index UQE_api_key_account_id_name - v1	DROP INDEX "UQE_api_key_account_id_name" CASCADE	t		2024-03-25 14:20:19
127	Rename table api_key to api_key_v1 - v1	ALTER TABLE "api_key" RENAME TO "api_key_v1"	t		2024-03-25 14:20:19
128	create api_key table v2	CREATE TABLE IF NOT EXISTS "api_key" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "org_id" BIGINT NOT NULL\n, "name" VARCHAR(190) NOT NULL\n, "key" VARCHAR(190) NOT NULL\n, "role" VARCHAR(255) NOT NULL\n, "created" TIMESTAMP NOT NULL\n, "updated" TIMESTAMP NOT NULL\n);	t		2024-03-25 14:20:19
129	create index IDX_api_key_org_id - v2	CREATE INDEX "IDX_api_key_org_id" ON "api_key" ("org_id");	t		2024-03-25 14:20:19
130	create index UQE_api_key_key - v2	CREATE UNIQUE INDEX "UQE_api_key_key" ON "api_key" ("key");	t		2024-03-25 14:20:19
131	create index UQE_api_key_org_id_name - v2	CREATE UNIQUE INDEX "UQE_api_key_org_id_name" ON "api_key" ("org_id","name");	t		2024-03-25 14:20:19
132	copy api_key v1 to v2	INSERT INTO "api_key" ("id"\n, "org_id"\n, "name"\n, "key"\n, "role"\n, "created"\n, "updated") SELECT "id"\n, "account_id"\n, "name"\n, "key"\n, "role"\n, "created"\n, "updated" FROM "api_key_v1"	t		2024-03-25 14:20:19
133	Drop old table api_key_v1	DROP TABLE IF EXISTS "api_key_v1"	t		2024-03-25 14:20:19
134	Update api_key table charset	ALTER TABLE "api_key" ALTER "name" TYPE VARCHAR(190), ALTER "key" TYPE VARCHAR(190), ALTER "role" TYPE VARCHAR(255);	t		2024-03-25 14:20:19
135	Add expires to api_key table	alter table "api_key" ADD COLUMN "expires" BIGINT NULL 	t		2024-03-25 14:20:19
136	Add service account foreign key	alter table "api_key" ADD COLUMN "service_account_id" BIGINT NULL 	t		2024-03-25 14:20:19
137	set service account foreign key to nil if 0	UPDATE api_key SET service_account_id = NULL WHERE service_account_id = 0;	t		2024-03-25 14:20:19
138	Add last_used_at to api_key table	alter table "api_key" ADD COLUMN "last_used_at" TIMESTAMP NULL 	t		2024-03-25 14:20:19
139	Add is_revoked column to api_key table	alter table "api_key" ADD COLUMN "is_revoked" BOOL NULL DEFAULT false 	t		2024-03-25 14:20:19
140	create dashboard_snapshot table v4	CREATE TABLE IF NOT EXISTS "dashboard_snapshot" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "name" VARCHAR(255) NOT NULL\n, "key" VARCHAR(190) NOT NULL\n, "dashboard" TEXT NOT NULL\n, "expires" TIMESTAMP NOT NULL\n, "created" TIMESTAMP NOT NULL\n, "updated" TIMESTAMP NOT NULL\n);	t		2024-03-25 14:20:19
141	drop table dashboard_snapshot_v4 #1	DROP TABLE IF EXISTS "dashboard_snapshot"	t		2024-03-25 14:20:19
142	create dashboard_snapshot table v5 #2	CREATE TABLE IF NOT EXISTS "dashboard_snapshot" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "name" VARCHAR(255) NOT NULL\n, "key" VARCHAR(190) NOT NULL\n, "delete_key" VARCHAR(190) NOT NULL\n, "org_id" BIGINT NOT NULL\n, "user_id" BIGINT NOT NULL\n, "external" BOOL NOT NULL\n, "external_url" VARCHAR(255) NOT NULL\n, "dashboard" TEXT NOT NULL\n, "expires" TIMESTAMP NOT NULL\n, "created" TIMESTAMP NOT NULL\n, "updated" TIMESTAMP NOT NULL\n);	t		2024-03-25 14:20:19
143	create index UQE_dashboard_snapshot_key - v5	CREATE UNIQUE INDEX "UQE_dashboard_snapshot_key" ON "dashboard_snapshot" ("key");	t		2024-03-25 14:20:19
144	create index UQE_dashboard_snapshot_delete_key - v5	CREATE UNIQUE INDEX "UQE_dashboard_snapshot_delete_key" ON "dashboard_snapshot" ("delete_key");	t		2024-03-25 14:20:19
145	create index IDX_dashboard_snapshot_user_id - v5	CREATE INDEX "IDX_dashboard_snapshot_user_id" ON "dashboard_snapshot" ("user_id");	t		2024-03-25 14:20:19
146	alter dashboard_snapshot to mediumtext v2	SELECT 0;	t		2024-03-25 14:20:19
147	Update dashboard_snapshot table charset	ALTER TABLE "dashboard_snapshot" ALTER "name" TYPE VARCHAR(255), ALTER "key" TYPE VARCHAR(190), ALTER "delete_key" TYPE VARCHAR(190), ALTER "external_url" TYPE VARCHAR(255), ALTER "dashboard" TYPE TEXT;	t		2024-03-25 14:20:19
148	Add column external_delete_url to dashboard_snapshots table	alter table "dashboard_snapshot" ADD COLUMN "external_delete_url" VARCHAR(255) NULL 	t		2024-03-25 14:20:19
149	Add encrypted dashboard json column	alter table "dashboard_snapshot" ADD COLUMN "dashboard_encrypted" BYTEA NULL 	t		2024-03-25 14:20:19
150	Change dashboard_encrypted column to MEDIUMBLOB	SELECT 0;	t		2024-03-25 14:20:19
151	create quota table v1	CREATE TABLE IF NOT EXISTS "quota" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "org_id" BIGINT NULL\n, "user_id" BIGINT NULL\n, "target" VARCHAR(190) NOT NULL\n, "limit" BIGINT NOT NULL\n, "created" TIMESTAMP NOT NULL\n, "updated" TIMESTAMP NOT NULL\n);	t		2024-03-25 14:20:19
152	create index UQE_quota_org_id_user_id_target - v1	CREATE UNIQUE INDEX "UQE_quota_org_id_user_id_target" ON "quota" ("org_id","user_id","target");	t		2024-03-25 14:20:19
153	Update quota table charset	ALTER TABLE "quota" ALTER "target" TYPE VARCHAR(190);	t		2024-03-25 14:20:19
154	create plugin_setting table	CREATE TABLE IF NOT EXISTS "plugin_setting" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "org_id" BIGINT NULL\n, "plugin_id" VARCHAR(190) NOT NULL\n, "enabled" BOOL NOT NULL\n, "pinned" BOOL NOT NULL\n, "json_data" TEXT NULL\n, "secure_json_data" TEXT NULL\n, "created" TIMESTAMP NOT NULL\n, "updated" TIMESTAMP NOT NULL\n);	t		2024-03-25 14:20:19
155	create index UQE_plugin_setting_org_id_plugin_id - v1	CREATE UNIQUE INDEX "UQE_plugin_setting_org_id_plugin_id" ON "plugin_setting" ("org_id","plugin_id");	t		2024-03-25 14:20:20
156	Add column plugin_version to plugin_settings	alter table "plugin_setting" ADD COLUMN "plugin_version" VARCHAR(50) NULL 	t		2024-03-25 14:20:20
157	Update plugin_setting table charset	ALTER TABLE "plugin_setting" ALTER "plugin_id" TYPE VARCHAR(190), ALTER "json_data" TYPE TEXT, ALTER "secure_json_data" TYPE TEXT, ALTER "plugin_version" TYPE VARCHAR(50);	t		2024-03-25 14:20:20
158	create session table	CREATE TABLE IF NOT EXISTS "session" (\n"key" CHAR(16) PRIMARY KEY NOT NULL\n, "data" BYTEA NOT NULL\n, "expiry" INTEGER NOT NULL\n);	t		2024-03-25 14:20:20
159	Drop old table playlist table	DROP TABLE IF EXISTS "playlist"	t		2024-03-25 14:20:20
160	Drop old table playlist_item table	DROP TABLE IF EXISTS "playlist_item"	t		2024-03-25 14:20:20
161	create playlist table v2	CREATE TABLE IF NOT EXISTS "playlist" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "name" VARCHAR(255) NOT NULL\n, "interval" VARCHAR(255) NOT NULL\n, "org_id" BIGINT NOT NULL\n);	t		2024-03-25 14:20:20
162	create playlist item table v2	CREATE TABLE IF NOT EXISTS "playlist_item" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "playlist_id" BIGINT NOT NULL\n, "type" VARCHAR(255) NOT NULL\n, "value" TEXT NOT NULL\n, "title" TEXT NOT NULL\n, "order" INTEGER NOT NULL\n);	t		2024-03-25 14:20:20
163	Update playlist table charset	ALTER TABLE "playlist" ALTER "name" TYPE VARCHAR(255), ALTER "interval" TYPE VARCHAR(255);	t		2024-03-25 14:20:20
164	Update playlist_item table charset	ALTER TABLE "playlist_item" ALTER "type" TYPE VARCHAR(255), ALTER "value" TYPE TEXT, ALTER "title" TYPE TEXT;	t		2024-03-25 14:20:20
165	Add playlist column created_at	alter table "playlist" ADD COLUMN "created_at" BIGINT NOT NULL DEFAULT 0 	t		2024-03-25 14:20:20
166	Add playlist column updated_at	alter table "playlist" ADD COLUMN "updated_at" BIGINT NOT NULL DEFAULT 0 	t		2024-03-25 14:20:20
167	drop preferences table v2	DROP TABLE IF EXISTS "preferences"	t		2024-03-25 14:20:20
168	drop preferences table v3	DROP TABLE IF EXISTS "preferences"	t		2024-03-25 14:20:20
169	create preferences table v3	CREATE TABLE IF NOT EXISTS "preferences" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "org_id" BIGINT NOT NULL\n, "user_id" BIGINT NOT NULL\n, "version" INTEGER NOT NULL\n, "home_dashboard_id" BIGINT NOT NULL\n, "timezone" VARCHAR(50) NOT NULL\n, "theme" VARCHAR(20) NOT NULL\n, "created" TIMESTAMP NOT NULL\n, "updated" TIMESTAMP NOT NULL\n);	t		2024-03-25 14:20:20
170	Update preferences table charset	ALTER TABLE "preferences" ALTER "timezone" TYPE VARCHAR(50), ALTER "theme" TYPE VARCHAR(20);	t		2024-03-25 14:20:20
171	Add column team_id in preferences	alter table "preferences" ADD COLUMN "team_id" BIGINT NULL 	t		2024-03-25 14:20:20
172	Update team_id column values in preferences	UPDATE preferences SET team_id=0 WHERE team_id IS NULL;	t		2024-03-25 14:20:20
173	Add column week_start in preferences	alter table "preferences" ADD COLUMN "week_start" VARCHAR(10) NULL 	t		2024-03-25 14:20:20
174	Add column preferences.json_data	alter table "preferences" ADD COLUMN "json_data" TEXT NULL 	t		2024-03-25 14:20:20
175	alter preferences.json_data to mediumtext v1	SELECT 0;	t		2024-03-25 14:20:20
176	Add preferences index org_id	CREATE INDEX "IDX_preferences_org_id" ON "preferences" ("org_id");	t		2024-03-25 14:20:20
177	Add preferences index user_id	CREATE INDEX "IDX_preferences_user_id" ON "preferences" ("user_id");	t		2024-03-25 14:20:20
178	create alert table v1	CREATE TABLE IF NOT EXISTS "alert" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "version" BIGINT NOT NULL\n, "dashboard_id" BIGINT NOT NULL\n, "panel_id" BIGINT NOT NULL\n, "org_id" BIGINT NOT NULL\n, "name" VARCHAR(255) NOT NULL\n, "message" TEXT NOT NULL\n, "state" VARCHAR(190) NOT NULL\n, "settings" TEXT NOT NULL\n, "frequency" BIGINT NOT NULL\n, "handler" BIGINT NOT NULL\n, "severity" TEXT NOT NULL\n, "silenced" BOOL NOT NULL\n, "execution_error" TEXT NOT NULL\n, "eval_data" TEXT NULL\n, "eval_date" TIMESTAMP NULL\n, "new_state_date" TIMESTAMP NOT NULL\n, "state_changes" INTEGER NOT NULL\n, "created" TIMESTAMP NOT NULL\n, "updated" TIMESTAMP NOT NULL\n);	t		2024-03-25 14:20:20
179	add index alert org_id & id 	CREATE INDEX "IDX_alert_org_id_id" ON "alert" ("org_id","id");	t		2024-03-25 14:20:20
180	add index alert state	CREATE INDEX "IDX_alert_state" ON "alert" ("state");	t		2024-03-25 14:20:20
181	add index alert dashboard_id	CREATE INDEX "IDX_alert_dashboard_id" ON "alert" ("dashboard_id");	t		2024-03-25 14:20:20
182	Create alert_rule_tag table v1	CREATE TABLE IF NOT EXISTS "alert_rule_tag" (\n"alert_id" BIGINT NOT NULL\n, "tag_id" BIGINT NOT NULL\n);	t		2024-03-25 14:20:20
183	Add unique index alert_rule_tag.alert_id_tag_id	CREATE UNIQUE INDEX "UQE_alert_rule_tag_alert_id_tag_id" ON "alert_rule_tag" ("alert_id","tag_id");	t		2024-03-25 14:20:20
184	drop index UQE_alert_rule_tag_alert_id_tag_id - v1	DROP INDEX "UQE_alert_rule_tag_alert_id_tag_id" CASCADE	t		2024-03-25 14:20:20
185	Rename table alert_rule_tag to alert_rule_tag_v1 - v1	ALTER TABLE "alert_rule_tag" RENAME TO "alert_rule_tag_v1"	t		2024-03-25 14:20:20
186	Create alert_rule_tag table v2	CREATE TABLE IF NOT EXISTS "alert_rule_tag" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "alert_id" BIGINT NOT NULL\n, "tag_id" BIGINT NOT NULL\n);	t		2024-03-25 14:20:20
187	create index UQE_alert_rule_tag_alert_id_tag_id - Add unique index alert_rule_tag.alert_id_tag_id V2	CREATE UNIQUE INDEX "UQE_alert_rule_tag_alert_id_tag_id" ON "alert_rule_tag" ("alert_id","tag_id");	t		2024-03-25 14:20:20
188	copy alert_rule_tag v1 to v2	INSERT INTO "alert_rule_tag" ("alert_id"\n, "tag_id") SELECT "alert_id"\n, "tag_id" FROM "alert_rule_tag_v1"	t		2024-03-25 14:20:20
189	drop table alert_rule_tag_v1	DROP TABLE IF EXISTS "alert_rule_tag_v1"	t		2024-03-25 14:20:20
190	create alert_notification table v1	CREATE TABLE IF NOT EXISTS "alert_notification" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "org_id" BIGINT NOT NULL\n, "name" VARCHAR(190) NOT NULL\n, "type" VARCHAR(255) NOT NULL\n, "settings" TEXT NOT NULL\n, "created" TIMESTAMP NOT NULL\n, "updated" TIMESTAMP NOT NULL\n);	t		2024-03-25 14:20:20
191	Add column is_default	alter table "alert_notification" ADD COLUMN "is_default" BOOL NOT NULL DEFAULT false 	t		2024-03-25 14:20:20
192	Add column frequency	alter table "alert_notification" ADD COLUMN "frequency" BIGINT NULL 	t		2024-03-25 14:20:20
193	Add column send_reminder	alter table "alert_notification" ADD COLUMN "send_reminder" BOOL NULL DEFAULT false 	t		2024-03-25 14:20:20
194	Add column disable_resolve_message	alter table "alert_notification" ADD COLUMN "disable_resolve_message" BOOL NOT NULL DEFAULT false 	t		2024-03-25 14:20:20
195	add index alert_notification org_id & name	CREATE UNIQUE INDEX "UQE_alert_notification_org_id_name" ON "alert_notification" ("org_id","name");	t		2024-03-25 14:20:20
196	Update alert table charset	ALTER TABLE "alert" ALTER "name" TYPE VARCHAR(255), ALTER "message" TYPE TEXT, ALTER "state" TYPE VARCHAR(190), ALTER "settings" TYPE TEXT, ALTER "severity" TYPE TEXT, ALTER "execution_error" TYPE TEXT, ALTER "eval_data" TYPE TEXT;	t		2024-03-25 14:20:20
197	Update alert_notification table charset	ALTER TABLE "alert_notification" ALTER "name" TYPE VARCHAR(190), ALTER "type" TYPE VARCHAR(255), ALTER "settings" TYPE TEXT;	t		2024-03-25 14:20:20
198	create notification_journal table v1	CREATE TABLE IF NOT EXISTS "alert_notification_journal" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "org_id" BIGINT NOT NULL\n, "alert_id" BIGINT NOT NULL\n, "notifier_id" BIGINT NOT NULL\n, "sent_at" BIGINT NOT NULL\n, "success" BOOL NOT NULL\n);	t		2024-03-25 14:20:20
199	add index notification_journal org_id & alert_id & notifier_id	CREATE INDEX "IDX_alert_notification_journal_org_id_alert_id_notifier_id" ON "alert_notification_journal" ("org_id","alert_id","notifier_id");	t		2024-03-25 14:20:20
200	drop alert_notification_journal	DROP TABLE IF EXISTS "alert_notification_journal"	t		2024-03-25 14:20:20
201	create alert_notification_state table v1	CREATE TABLE IF NOT EXISTS "alert_notification_state" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "org_id" BIGINT NOT NULL\n, "alert_id" BIGINT NOT NULL\n, "notifier_id" BIGINT NOT NULL\n, "state" VARCHAR(50) NOT NULL\n, "version" BIGINT NOT NULL\n, "updated_at" BIGINT NOT NULL\n, "alert_rule_state_updated_version" BIGINT NOT NULL\n);	t		2024-03-25 14:20:20
202	add index alert_notification_state org_id & alert_id & notifier_id	CREATE UNIQUE INDEX "UQE_alert_notification_state_org_id_alert_id_notifier_id" ON "alert_notification_state" ("org_id","alert_id","notifier_id");	t		2024-03-25 14:20:20
203	Add for to alert table	alter table "alert" ADD COLUMN "for" BIGINT NULL 	t		2024-03-25 14:20:20
204	Add column uid in alert_notification	alter table "alert_notification" ADD COLUMN "uid" VARCHAR(40) NULL 	t		2024-03-25 14:20:20
205	Update uid column values in alert_notification	UPDATE alert_notification SET uid=lpad('' || id::text,9,'0') WHERE uid IS NULL;	t		2024-03-25 14:20:20
206	Add unique index alert_notification_org_id_uid	CREATE UNIQUE INDEX "UQE_alert_notification_org_id_uid" ON "alert_notification" ("org_id","uid");	t		2024-03-25 14:20:20
207	Remove unique index org_id_name	DROP INDEX "UQE_alert_notification_org_id_name" CASCADE	t		2024-03-25 14:20:20
407	add column display_name	alter table "role" ADD COLUMN "display_name" VARCHAR(190) NULL 	t		2024-03-25 14:20:20
208	Add column secure_settings in alert_notification	alter table "alert_notification" ADD COLUMN "secure_settings" TEXT NULL 	t		2024-03-25 14:20:20
209	alter alert.settings to mediumtext	SELECT 0;	t		2024-03-25 14:20:20
210	Add non-unique index alert_notification_state_alert_id	CREATE INDEX "IDX_alert_notification_state_alert_id" ON "alert_notification_state" ("alert_id");	t		2024-03-25 14:20:20
211	Add non-unique index alert_rule_tag_alert_id	CREATE INDEX "IDX_alert_rule_tag_alert_id" ON "alert_rule_tag" ("alert_id");	t		2024-03-25 14:20:20
212	Drop old annotation table v4	DROP TABLE IF EXISTS "annotation"	t		2024-03-25 14:20:20
213	create annotation table v5	CREATE TABLE IF NOT EXISTS "annotation" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "org_id" BIGINT NOT NULL\n, "alert_id" BIGINT NULL\n, "user_id" BIGINT NULL\n, "dashboard_id" BIGINT NULL\n, "panel_id" BIGINT NULL\n, "category_id" BIGINT NULL\n, "type" VARCHAR(25) NOT NULL\n, "title" TEXT NOT NULL\n, "text" TEXT NOT NULL\n, "metric" VARCHAR(255) NULL\n, "prev_state" VARCHAR(25) NOT NULL\n, "new_state" VARCHAR(25) NOT NULL\n, "data" TEXT NOT NULL\n, "epoch" BIGINT NOT NULL\n);	t		2024-03-25 14:20:20
214	add index annotation 0 v3	CREATE INDEX "IDX_annotation_org_id_alert_id" ON "annotation" ("org_id","alert_id");	t		2024-03-25 14:20:20
215	add index annotation 1 v3	CREATE INDEX "IDX_annotation_org_id_type" ON "annotation" ("org_id","type");	t		2024-03-25 14:20:20
216	add index annotation 2 v3	CREATE INDEX "IDX_annotation_org_id_category_id" ON "annotation" ("org_id","category_id");	t		2024-03-25 14:20:20
217	add index annotation 3 v3	CREATE INDEX "IDX_annotation_org_id_dashboard_id_panel_id_epoch" ON "annotation" ("org_id","dashboard_id","panel_id","epoch");	t		2024-03-25 14:20:20
218	add index annotation 4 v3	CREATE INDEX "IDX_annotation_org_id_epoch" ON "annotation" ("org_id","epoch");	t		2024-03-25 14:20:20
219	Update annotation table charset	ALTER TABLE "annotation" ALTER "type" TYPE VARCHAR(25), ALTER "title" TYPE TEXT, ALTER "text" TYPE TEXT, ALTER "metric" TYPE VARCHAR(255), ALTER "prev_state" TYPE VARCHAR(25), ALTER "new_state" TYPE VARCHAR(25), ALTER "data" TYPE TEXT;	t		2024-03-25 14:20:20
220	Add column region_id to annotation table	alter table "annotation" ADD COLUMN "region_id" BIGINT NULL DEFAULT 0 	t		2024-03-25 14:20:20
221	Drop category_id index	DROP INDEX "IDX_annotation_org_id_category_id" CASCADE	t		2024-03-25 14:20:20
222	Add column tags to annotation table	alter table "annotation" ADD COLUMN "tags" VARCHAR(500) NULL 	t		2024-03-25 14:20:20
223	Create annotation_tag table v2	CREATE TABLE IF NOT EXISTS "annotation_tag" (\n"annotation_id" BIGINT NOT NULL\n, "tag_id" BIGINT NOT NULL\n);	t		2024-03-25 14:20:20
224	Add unique index annotation_tag.annotation_id_tag_id	CREATE UNIQUE INDEX "UQE_annotation_tag_annotation_id_tag_id" ON "annotation_tag" ("annotation_id","tag_id");	t		2024-03-25 14:20:20
225	drop index UQE_annotation_tag_annotation_id_tag_id - v2	DROP INDEX "UQE_annotation_tag_annotation_id_tag_id" CASCADE	t		2024-03-25 14:20:20
226	Rename table annotation_tag to annotation_tag_v2 - v2	ALTER TABLE "annotation_tag" RENAME TO "annotation_tag_v2"	t		2024-03-25 14:20:20
227	Create annotation_tag table v3	CREATE TABLE IF NOT EXISTS "annotation_tag" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "annotation_id" BIGINT NOT NULL\n, "tag_id" BIGINT NOT NULL\n);	t		2024-03-25 14:20:20
228	create index UQE_annotation_tag_annotation_id_tag_id - Add unique index annotation_tag.annotation_id_tag_id V3	CREATE UNIQUE INDEX "UQE_annotation_tag_annotation_id_tag_id" ON "annotation_tag" ("annotation_id","tag_id");	t		2024-03-25 14:20:20
229	copy annotation_tag v2 to v3	INSERT INTO "annotation_tag" ("annotation_id"\n, "tag_id") SELECT "annotation_id"\n, "tag_id" FROM "annotation_tag_v2"	t		2024-03-25 14:20:20
230	drop table annotation_tag_v2	DROP TABLE IF EXISTS "annotation_tag_v2"	t		2024-03-25 14:20:20
231	Update alert annotations and set TEXT to empty	UPDATE annotation SET TEXT = '' WHERE alert_id > 0	t		2024-03-25 14:20:20
232	Add created time to annotation table	alter table "annotation" ADD COLUMN "created" BIGINT NULL DEFAULT 0 	t		2024-03-25 14:20:20
233	Add updated time to annotation table	alter table "annotation" ADD COLUMN "updated" BIGINT NULL DEFAULT 0 	t		2024-03-25 14:20:20
234	Add index for created in annotation table	CREATE INDEX "IDX_annotation_org_id_created" ON "annotation" ("org_id","created");	t		2024-03-25 14:20:20
235	Add index for updated in annotation table	CREATE INDEX "IDX_annotation_org_id_updated" ON "annotation" ("org_id","updated");	t		2024-03-25 14:20:20
236	Convert existing annotations from seconds to milliseconds	UPDATE annotation SET epoch = (epoch*1000) where epoch < 9999999999	t		2024-03-25 14:20:20
237	Add epoch_end column	alter table "annotation" ADD COLUMN "epoch_end" BIGINT NOT NULL DEFAULT 0 	t		2024-03-25 14:20:20
238	Add index for epoch_end	CREATE INDEX "IDX_annotation_org_id_epoch_epoch_end" ON "annotation" ("org_id","epoch","epoch_end");	t		2024-03-25 14:20:20
239	Make epoch_end the same as epoch	UPDATE annotation SET epoch_end = epoch	t		2024-03-25 14:20:20
240	Move region to single row	code migration	t		2024-03-25 14:20:20
241	Remove index org_id_epoch from annotation table	DROP INDEX "IDX_annotation_org_id_epoch" CASCADE	t		2024-03-25 14:20:20
242	Remove index org_id_dashboard_id_panel_id_epoch from annotation table	DROP INDEX "IDX_annotation_org_id_dashboard_id_panel_id_epoch" CASCADE	t		2024-03-25 14:20:20
243	Add index for org_id_dashboard_id_epoch_end_epoch on annotation table	CREATE INDEX "IDX_annotation_org_id_dashboard_id_epoch_end_epoch" ON "annotation" ("org_id","dashboard_id","epoch_end","epoch");	t		2024-03-25 14:20:20
244	Add index for org_id_epoch_end_epoch on annotation table	CREATE INDEX "IDX_annotation_org_id_epoch_end_epoch" ON "annotation" ("org_id","epoch_end","epoch");	t		2024-03-25 14:20:20
245	Remove index org_id_epoch_epoch_end from annotation table	DROP INDEX "IDX_annotation_org_id_epoch_epoch_end" CASCADE	t		2024-03-25 14:20:20
246	Add index for alert_id on annotation table	CREATE INDEX "IDX_annotation_alert_id" ON "annotation" ("alert_id");	t		2024-03-25 14:20:20
247	Increase tags column to length 4096	ALTER TABLE annotation ALTER COLUMN tags TYPE VARCHAR(4096);	t		2024-03-25 14:20:20
248	create test_data table	CREATE TABLE IF NOT EXISTS "test_data" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "metric1" VARCHAR(20) NULL\n, "metric2" VARCHAR(150) NULL\n, "value_big_int" BIGINT NULL\n, "value_double" DOUBLE PRECISION NULL\n, "value_float" REAL NULL\n, "value_int" INTEGER NULL\n, "time_epoch" BIGINT NOT NULL\n, "time_date_time" TIMESTAMP NOT NULL\n, "time_time_stamp" TIMESTAMP NOT NULL\n);	t		2024-03-25 14:20:20
249	create dashboard_version table v1	CREATE TABLE IF NOT EXISTS "dashboard_version" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "dashboard_id" BIGINT NOT NULL\n, "parent_version" INTEGER NOT NULL\n, "restored_from" INTEGER NOT NULL\n, "version" INTEGER NOT NULL\n, "created" TIMESTAMP NOT NULL\n, "created_by" BIGINT NOT NULL\n, "message" TEXT NOT NULL\n, "data" TEXT NOT NULL\n);	t		2024-03-25 14:20:20
250	add index dashboard_version.dashboard_id	CREATE INDEX "IDX_dashboard_version_dashboard_id" ON "dashboard_version" ("dashboard_id");	t		2024-03-25 14:20:20
251	add unique index dashboard_version.dashboard_id and dashboard_version.version	CREATE UNIQUE INDEX "UQE_dashboard_version_dashboard_id_version" ON "dashboard_version" ("dashboard_id","version");	t		2024-03-25 14:20:20
252	Set dashboard version to 1 where 0	UPDATE dashboard SET version = 1 WHERE version = 0	t		2024-03-25 14:20:20
253	save existing dashboard data in dashboard_version table v1	INSERT INTO dashboard_version\n(\n\tdashboard_id,\n\tversion,\n\tparent_version,\n\trestored_from,\n\tcreated,\n\tcreated_by,\n\tmessage,\n\tdata\n)\nSELECT\n\tdashboard.id,\n\tdashboard.version,\n\tdashboard.version,\n\tdashboard.version,\n\tdashboard.updated,\n\tCOALESCE(dashboard.updated_by, -1),\n\t'',\n\tdashboard.data\nFROM dashboard;	t		2024-03-25 14:20:20
254	alter dashboard_version.data to mediumtext v1	SELECT 0;	t		2024-03-25 14:20:20
255	create team table	CREATE TABLE IF NOT EXISTS "team" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "name" VARCHAR(190) NOT NULL\n, "org_id" BIGINT NOT NULL\n, "created" TIMESTAMP NOT NULL\n, "updated" TIMESTAMP NOT NULL\n);	t		2024-03-25 14:20:20
256	add index team.org_id	CREATE INDEX "IDX_team_org_id" ON "team" ("org_id");	t		2024-03-25 14:20:20
257	add unique index team_org_id_name	CREATE UNIQUE INDEX "UQE_team_org_id_name" ON "team" ("org_id","name");	t		2024-03-25 14:20:20
258	Add column uid in team	alter table "team" ADD COLUMN "uid" VARCHAR(40) NULL 	t		2024-03-25 14:20:20
259	Update uid column values in team	UPDATE team SET uid='t' || lpad('' || id::text,9,'0') WHERE uid IS NULL;	t		2024-03-25 14:20:20
260	Add unique index team_org_id_uid	CREATE UNIQUE INDEX "UQE_team_org_id_uid" ON "team" ("org_id","uid");	t		2024-03-25 14:20:20
261	create team member table	CREATE TABLE IF NOT EXISTS "team_member" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "org_id" BIGINT NOT NULL\n, "team_id" BIGINT NOT NULL\n, "user_id" BIGINT NOT NULL\n, "created" TIMESTAMP NOT NULL\n, "updated" TIMESTAMP NOT NULL\n);	t		2024-03-25 14:20:20
262	add index team_member.org_id	CREATE INDEX "IDX_team_member_org_id" ON "team_member" ("org_id");	t		2024-03-25 14:20:20
263	add unique index team_member_org_id_team_id_user_id	CREATE UNIQUE INDEX "UQE_team_member_org_id_team_id_user_id" ON "team_member" ("org_id","team_id","user_id");	t		2024-03-25 14:20:20
264	add index team_member.team_id	CREATE INDEX "IDX_team_member_team_id" ON "team_member" ("team_id");	t		2024-03-25 14:20:20
265	Add column email to team table	alter table "team" ADD COLUMN "email" VARCHAR(190) NULL 	t		2024-03-25 14:20:20
266	Add column external to team_member table	alter table "team_member" ADD COLUMN "external" BOOL NULL 	t		2024-03-25 14:20:20
267	Add column permission to team_member table	alter table "team_member" ADD COLUMN "permission" SMALLINT NULL 	t		2024-03-25 14:20:20
268	create dashboard acl table	CREATE TABLE IF NOT EXISTS "dashboard_acl" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "org_id" BIGINT NOT NULL\n, "dashboard_id" BIGINT NOT NULL\n, "user_id" BIGINT NULL\n, "team_id" BIGINT NULL\n, "permission" SMALLINT NOT NULL DEFAULT 4\n, "role" VARCHAR(20) NULL\n, "created" TIMESTAMP NOT NULL\n, "updated" TIMESTAMP NOT NULL\n);	t		2024-03-25 14:20:20
269	add index dashboard_acl_dashboard_id	CREATE INDEX "IDX_dashboard_acl_dashboard_id" ON "dashboard_acl" ("dashboard_id");	t		2024-03-25 14:20:20
270	add unique index dashboard_acl_dashboard_id_user_id	CREATE UNIQUE INDEX "UQE_dashboard_acl_dashboard_id_user_id" ON "dashboard_acl" ("dashboard_id","user_id");	t		2024-03-25 14:20:20
271	add unique index dashboard_acl_dashboard_id_team_id	CREATE UNIQUE INDEX "UQE_dashboard_acl_dashboard_id_team_id" ON "dashboard_acl" ("dashboard_id","team_id");	t		2024-03-25 14:20:20
272	add index dashboard_acl_user_id	CREATE INDEX "IDX_dashboard_acl_user_id" ON "dashboard_acl" ("user_id");	t		2024-03-25 14:20:20
273	add index dashboard_acl_team_id	CREATE INDEX "IDX_dashboard_acl_team_id" ON "dashboard_acl" ("team_id");	t		2024-03-25 14:20:20
274	add index dashboard_acl_org_id_role	CREATE INDEX "IDX_dashboard_acl_org_id_role" ON "dashboard_acl" ("org_id","role");	t		2024-03-25 14:20:20
275	add index dashboard_permission	CREATE INDEX "IDX_dashboard_acl_permission" ON "dashboard_acl" ("permission");	t		2024-03-25 14:20:20
276	save default acl rules in dashboard_acl table	\nINSERT INTO dashboard_acl\n\t(\n\t\torg_id,\n\t\tdashboard_id,\n\t\tpermission,\n\t\trole,\n\t\tcreated,\n\t\tupdated\n\t)\n\tVALUES\n\t\t(-1,-1, 1,'Viewer','2017-06-20','2017-06-20'),\n\t\t(-1,-1, 2,'Editor','2017-06-20','2017-06-20')\n\t	t		2024-03-25 14:20:20
277	delete acl rules for deleted dashboards and folders	DELETE FROM dashboard_acl WHERE dashboard_id NOT IN (SELECT id FROM dashboard) AND dashboard_id != -1	t		2024-03-25 14:20:20
278	create tag table	CREATE TABLE IF NOT EXISTS "tag" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "key" VARCHAR(100) NOT NULL\n, "value" VARCHAR(100) NOT NULL\n);	t		2024-03-25 14:20:20
279	add index tag.key_value	CREATE UNIQUE INDEX "UQE_tag_key_value" ON "tag" ("key","value");	t		2024-03-25 14:20:20
280	create login attempt table	CREATE TABLE IF NOT EXISTS "login_attempt" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "username" VARCHAR(190) NOT NULL\n, "ip_address" VARCHAR(30) NOT NULL\n, "created" TIMESTAMP NOT NULL\n);	t		2024-03-25 14:20:20
281	add index login_attempt.username	CREATE INDEX "IDX_login_attempt_username" ON "login_attempt" ("username");	t		2024-03-25 14:20:20
282	drop index IDX_login_attempt_username - v1	DROP INDEX "IDX_login_attempt_username" CASCADE	t		2024-03-25 14:20:20
283	Rename table login_attempt to login_attempt_tmp_qwerty - v1	ALTER TABLE "login_attempt" RENAME TO "login_attempt_tmp_qwerty"	t		2024-03-25 14:20:20
284	create login_attempt v2	CREATE TABLE IF NOT EXISTS "login_attempt" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "username" VARCHAR(190) NOT NULL\n, "ip_address" VARCHAR(30) NOT NULL\n, "created" INTEGER NOT NULL DEFAULT 0\n);	t		2024-03-25 14:20:20
285	create index IDX_login_attempt_username - v2	CREATE INDEX "IDX_login_attempt_username" ON "login_attempt" ("username");	t		2024-03-25 14:20:20
286	copy login_attempt v1 to v2	INSERT INTO "login_attempt" ("id"\n, "username"\n, "ip_address") SELECT "id"\n, "username"\n, "ip_address" FROM "login_attempt_tmp_qwerty"	t		2024-03-25 14:20:20
287	drop login_attempt_tmp_qwerty	DROP TABLE IF EXISTS "login_attempt_tmp_qwerty"	t		2024-03-25 14:20:20
288	create user auth table	CREATE TABLE IF NOT EXISTS "user_auth" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "user_id" BIGINT NOT NULL\n, "auth_module" VARCHAR(190) NOT NULL\n, "auth_id" VARCHAR(100) NOT NULL\n, "created" TIMESTAMP NOT NULL\n);	t		2024-03-25 14:20:20
289	create index IDX_user_auth_auth_module_auth_id - v1	CREATE INDEX "IDX_user_auth_auth_module_auth_id" ON "user_auth" ("auth_module","auth_id");	t		2024-03-25 14:20:20
290	alter user_auth.auth_id to length 190	ALTER TABLE user_auth ALTER COLUMN auth_id TYPE VARCHAR(190);	t		2024-03-25 14:20:20
291	Add OAuth access token to user_auth	alter table "user_auth" ADD COLUMN "o_auth_access_token" TEXT NULL 	t		2024-03-25 14:20:20
292	Add OAuth refresh token to user_auth	alter table "user_auth" ADD COLUMN "o_auth_refresh_token" TEXT NULL 	t		2024-03-25 14:20:20
293	Add OAuth token type to user_auth	alter table "user_auth" ADD COLUMN "o_auth_token_type" TEXT NULL 	t		2024-03-25 14:20:20
294	Add OAuth expiry to user_auth	alter table "user_auth" ADD COLUMN "o_auth_expiry" TIMESTAMP NULL 	t		2024-03-25 14:20:20
295	Add index to user_id column in user_auth	CREATE INDEX "IDX_user_auth_user_id" ON "user_auth" ("user_id");	t		2024-03-25 14:20:20
296	Add OAuth ID token to user_auth	alter table "user_auth" ADD COLUMN "o_auth_id_token" TEXT NULL 	t		2024-03-25 14:20:20
297	create server_lock table	CREATE TABLE IF NOT EXISTS "server_lock" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "operation_uid" VARCHAR(100) NOT NULL\n, "version" BIGINT NOT NULL\n, "last_execution" BIGINT NOT NULL\n);	t		2024-03-25 14:20:20
298	add index server_lock.operation_uid	CREATE UNIQUE INDEX "UQE_server_lock_operation_uid" ON "server_lock" ("operation_uid");	t		2024-03-25 14:20:20
299	create user auth token table	CREATE TABLE IF NOT EXISTS "user_auth_token" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "user_id" BIGINT NOT NULL\n, "auth_token" VARCHAR(100) NOT NULL\n, "prev_auth_token" VARCHAR(100) NOT NULL\n, "user_agent" VARCHAR(255) NOT NULL\n, "client_ip" VARCHAR(255) NOT NULL\n, "auth_token_seen" BOOL NOT NULL\n, "seen_at" INTEGER NULL\n, "rotated_at" INTEGER NOT NULL\n, "created_at" INTEGER NOT NULL\n, "updated_at" INTEGER NOT NULL\n);	t		2024-03-25 14:20:20
300	add unique index user_auth_token.auth_token	CREATE UNIQUE INDEX "UQE_user_auth_token_auth_token" ON "user_auth_token" ("auth_token");	t		2024-03-25 14:20:20
301	add unique index user_auth_token.prev_auth_token	CREATE UNIQUE INDEX "UQE_user_auth_token_prev_auth_token" ON "user_auth_token" ("prev_auth_token");	t		2024-03-25 14:20:20
302	add index user_auth_token.user_id	CREATE INDEX "IDX_user_auth_token_user_id" ON "user_auth_token" ("user_id");	t		2024-03-25 14:20:20
303	Add revoked_at to the user auth token	alter table "user_auth_token" ADD COLUMN "revoked_at" INTEGER NULL 	t		2024-03-25 14:20:20
304	add index user_auth_token.revoked_at	CREATE INDEX "IDX_user_auth_token_revoked_at" ON "user_auth_token" ("revoked_at");	t		2024-03-25 14:20:20
305	create cache_data table	CREATE TABLE IF NOT EXISTS "cache_data" (\n"cache_key" VARCHAR(168) PRIMARY KEY NOT NULL\n, "data" BYTEA NOT NULL\n, "expires" INTEGER NOT NULL\n, "created_at" INTEGER NOT NULL\n);	t		2024-03-25 14:20:20
306	add unique index cache_data.cache_key	CREATE UNIQUE INDEX "UQE_cache_data_cache_key" ON "cache_data" ("cache_key");	t		2024-03-25 14:20:20
307	create short_url table v1	CREATE TABLE IF NOT EXISTS "short_url" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "org_id" BIGINT NOT NULL\n, "uid" VARCHAR(40) NOT NULL\n, "path" TEXT NOT NULL\n, "created_by" INTEGER NOT NULL\n, "created_at" INTEGER NOT NULL\n, "last_seen_at" INTEGER NULL\n);	t		2024-03-25 14:20:20
308	add index short_url.org_id-uid	CREATE UNIQUE INDEX "UQE_short_url_org_id_uid" ON "short_url" ("org_id","uid");	t		2024-03-25 14:20:20
309	alter table short_url alter column created_by type to bigint	ALTER TABLE short_url ALTER COLUMN created_by TYPE BIGINT;	t		2024-03-25 14:20:20
310	delete alert_definition table	DROP TABLE IF EXISTS "alert_definition"	t		2024-03-25 14:20:20
311	recreate alert_definition table	CREATE TABLE IF NOT EXISTS "alert_definition" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "org_id" BIGINT NOT NULL\n, "title" VARCHAR(190) NOT NULL\n, "condition" VARCHAR(190) NOT NULL\n, "data" TEXT NOT NULL\n, "updated" TIMESTAMP NOT NULL\n, "interval_seconds" BIGINT NOT NULL DEFAULT 60\n, "version" INTEGER NOT NULL DEFAULT 0\n, "uid" VARCHAR(40) NOT NULL DEFAULT 0\n);	t		2024-03-25 14:20:20
312	add index in alert_definition on org_id and title columns	CREATE INDEX "IDX_alert_definition_org_id_title" ON "alert_definition" ("org_id","title");	t		2024-03-25 14:20:20
313	add index in alert_definition on org_id and uid columns	CREATE INDEX "IDX_alert_definition_org_id_uid" ON "alert_definition" ("org_id","uid");	t		2024-03-25 14:20:20
314	alter alert_definition table data column to mediumtext in mysql	SELECT 0;	t		2024-03-25 14:20:20
315	drop index in alert_definition on org_id and title columns	DROP INDEX "IDX_alert_definition_org_id_title" CASCADE	t		2024-03-25 14:20:20
316	drop index in alert_definition on org_id and uid columns	DROP INDEX "IDX_alert_definition_org_id_uid" CASCADE	t		2024-03-25 14:20:20
317	add unique index in alert_definition on org_id and title columns	CREATE UNIQUE INDEX "UQE_alert_definition_org_id_title" ON "alert_definition" ("org_id","title");	t		2024-03-25 14:20:20
318	add unique index in alert_definition on org_id and uid columns	CREATE UNIQUE INDEX "UQE_alert_definition_org_id_uid" ON "alert_definition" ("org_id","uid");	t		2024-03-25 14:20:20
319	Add column paused in alert_definition	alter table "alert_definition" ADD COLUMN "paused" BOOL NOT NULL DEFAULT false 	t		2024-03-25 14:20:20
320	drop alert_definition table	DROP TABLE IF EXISTS "alert_definition"	t		2024-03-25 14:20:20
321	delete alert_definition_version table	DROP TABLE IF EXISTS "alert_definition_version"	t		2024-03-25 14:20:20
322	recreate alert_definition_version table	CREATE TABLE IF NOT EXISTS "alert_definition_version" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "alert_definition_id" BIGINT NOT NULL\n, "alert_definition_uid" VARCHAR(40) NOT NULL DEFAULT 0\n, "parent_version" INTEGER NOT NULL\n, "restored_from" INTEGER NOT NULL\n, "version" INTEGER NOT NULL\n, "created" TIMESTAMP NOT NULL\n, "title" VARCHAR(190) NOT NULL\n, "condition" VARCHAR(190) NOT NULL\n, "data" TEXT NOT NULL\n, "interval_seconds" BIGINT NOT NULL\n);	t		2024-03-25 14:20:20
323	add index in alert_definition_version table on alert_definition_id and version columns	CREATE UNIQUE INDEX "UQE_alert_definition_version_alert_definition_id_version" ON "alert_definition_version" ("alert_definition_id","version");	t		2024-03-25 14:20:20
324	add index in alert_definition_version table on alert_definition_uid and version columns	CREATE UNIQUE INDEX "UQE_alert_definition_version_alert_definition_uid_version" ON "alert_definition_version" ("alert_definition_uid","version");	t		2024-03-25 14:20:20
325	alter alert_definition_version table data column to mediumtext in mysql	SELECT 0;	t		2024-03-25 14:20:20
326	drop alert_definition_version table	DROP TABLE IF EXISTS "alert_definition_version"	t		2024-03-25 14:20:20
327	create alert_instance table	CREATE TABLE IF NOT EXISTS "alert_instance" (\n"def_org_id" BIGINT NOT NULL\n, "def_uid" VARCHAR(40) NOT NULL DEFAULT 0\n, "labels" TEXT NOT NULL\n, "labels_hash" VARCHAR(190) NOT NULL\n, "current_state" VARCHAR(190) NOT NULL\n, "current_state_since" BIGINT NOT NULL\n, "last_eval_time" BIGINT NOT NULL\n, PRIMARY KEY ( "def_org_id","def_uid","labels_hash" ));	t		2024-03-25 14:20:20
328	add index in alert_instance table on def_org_id, def_uid and current_state columns	CREATE INDEX "IDX_alert_instance_def_org_id_def_uid_current_state" ON "alert_instance" ("def_org_id","def_uid","current_state");	t		2024-03-25 14:20:20
329	add index in alert_instance table on def_org_id, current_state columns	CREATE INDEX "IDX_alert_instance_def_org_id_current_state" ON "alert_instance" ("def_org_id","current_state");	t		2024-03-25 14:20:20
330	add column current_state_end to alert_instance	alter table "alert_instance" ADD COLUMN "current_state_end" BIGINT NOT NULL DEFAULT 0 	t		2024-03-25 14:20:20
331	remove index def_org_id, def_uid, current_state on alert_instance	DROP INDEX "IDX_alert_instance_def_org_id_def_uid_current_state" CASCADE	t		2024-03-25 14:20:20
332	remove index def_org_id, current_state on alert_instance	DROP INDEX "IDX_alert_instance_def_org_id_current_state" CASCADE	t		2024-03-25 14:20:20
333	rename def_org_id to rule_org_id in alert_instance	ALTER TABLE alert_instance RENAME COLUMN def_org_id TO rule_org_id;	t		2024-03-25 14:20:20
334	rename def_uid to rule_uid in alert_instance	ALTER TABLE alert_instance RENAME COLUMN def_uid TO rule_uid;	t		2024-03-25 14:20:20
335	add index rule_org_id, rule_uid, current_state on alert_instance	CREATE INDEX "IDX_alert_instance_rule_org_id_rule_uid_current_state" ON "alert_instance" ("rule_org_id","rule_uid","current_state");	t		2024-03-25 14:20:20
336	add index rule_org_id, current_state on alert_instance	CREATE INDEX "IDX_alert_instance_rule_org_id_current_state" ON "alert_instance" ("rule_org_id","current_state");	t		2024-03-25 14:20:20
337	add current_reason column related to current_state	alter table "alert_instance" ADD COLUMN "current_reason" VARCHAR(190) NULL 	t		2024-03-25 14:20:20
338	add result_fingerprint column to alert_instance	alter table "alert_instance" ADD COLUMN "result_fingerprint" VARCHAR(16) NULL 	t		2024-03-25 14:20:20
339	create alert_rule table	CREATE TABLE IF NOT EXISTS "alert_rule" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "org_id" BIGINT NOT NULL\n, "title" VARCHAR(190) NOT NULL\n, "condition" VARCHAR(190) NOT NULL\n, "data" TEXT NOT NULL\n, "updated" TIMESTAMP NOT NULL\n, "interval_seconds" BIGINT NOT NULL DEFAULT 60\n, "version" INTEGER NOT NULL DEFAULT 0\n, "uid" VARCHAR(40) NOT NULL DEFAULT 0\n, "namespace_uid" VARCHAR(40) NOT NULL\n, "rule_group" VARCHAR(190) NOT NULL\n, "no_data_state" VARCHAR(15) NOT NULL DEFAULT 'NoData'\n, "exec_err_state" VARCHAR(15) NOT NULL DEFAULT 'Alerting'\n);	t		2024-03-25 14:20:20
340	add index in alert_rule on org_id and title columns	CREATE UNIQUE INDEX "UQE_alert_rule_org_id_title" ON "alert_rule" ("org_id","title");	t		2024-03-25 14:20:20
341	add index in alert_rule on org_id and uid columns	CREATE UNIQUE INDEX "UQE_alert_rule_org_id_uid" ON "alert_rule" ("org_id","uid");	t		2024-03-25 14:20:20
342	add index in alert_rule on org_id, namespace_uid, group_uid columns	CREATE INDEX "IDX_alert_rule_org_id_namespace_uid_rule_group" ON "alert_rule" ("org_id","namespace_uid","rule_group");	t		2024-03-25 14:20:20
343	alter alert_rule table data column to mediumtext in mysql	SELECT 0;	t		2024-03-25 14:20:20
344	add column for to alert_rule	alter table "alert_rule" ADD COLUMN "for" BIGINT NOT NULL DEFAULT 0 	t		2024-03-25 14:20:20
345	add column annotations to alert_rule	alter table "alert_rule" ADD COLUMN "annotations" TEXT NULL 	t		2024-03-25 14:20:20
346	add column labels to alert_rule	alter table "alert_rule" ADD COLUMN "labels" TEXT NULL 	t		2024-03-25 14:20:20
347	remove unique index from alert_rule on org_id, title columns	DROP INDEX "UQE_alert_rule_org_id_title" CASCADE	t		2024-03-25 14:20:20
348	add index in alert_rule on org_id, namespase_uid and title columns	CREATE UNIQUE INDEX "UQE_alert_rule_org_id_namespace_uid_title" ON "alert_rule" ("org_id","namespace_uid","title");	t		2024-03-25 14:20:20
349	add dashboard_uid column to alert_rule	alter table "alert_rule" ADD COLUMN "dashboard_uid" VARCHAR(40) NULL 	t		2024-03-25 14:20:20
350	add panel_id column to alert_rule	alter table "alert_rule" ADD COLUMN "panel_id" BIGINT NULL 	t		2024-03-25 14:20:20
351	add index in alert_rule on org_id, dashboard_uid and panel_id columns	CREATE INDEX "IDX_alert_rule_org_id_dashboard_uid_panel_id" ON "alert_rule" ("org_id","dashboard_uid","panel_id");	t		2024-03-25 14:20:20
352	add rule_group_idx column to alert_rule	alter table "alert_rule" ADD COLUMN "rule_group_idx" INTEGER NOT NULL DEFAULT 1 	t		2024-03-25 14:20:20
353	add is_paused column to alert_rule table	alter table "alert_rule" ADD COLUMN "is_paused" BOOL NOT NULL DEFAULT false 	t		2024-03-25 14:20:20
354	fix is_paused column for alert_rule table	ALTER TABLE alert_rule ALTER COLUMN is_paused SET DEFAULT false;\nUPDATE alert_rule SET is_paused = false;	t		2024-03-25 14:20:20
355	create alert_rule_version table	CREATE TABLE IF NOT EXISTS "alert_rule_version" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "rule_org_id" BIGINT NOT NULL\n, "rule_uid" VARCHAR(40) NOT NULL DEFAULT 0\n, "rule_namespace_uid" VARCHAR(40) NOT NULL\n, "rule_group" VARCHAR(190) NOT NULL\n, "parent_version" INTEGER NOT NULL\n, "restored_from" INTEGER NOT NULL\n, "version" INTEGER NOT NULL\n, "created" TIMESTAMP NOT NULL\n, "title" VARCHAR(190) NOT NULL\n, "condition" VARCHAR(190) NOT NULL\n, "data" TEXT NOT NULL\n, "interval_seconds" BIGINT NOT NULL\n, "no_data_state" VARCHAR(15) NOT NULL DEFAULT 'NoData'\n, "exec_err_state" VARCHAR(15) NOT NULL DEFAULT 'Alerting'\n);	t		2024-03-25 14:20:20
356	add index in alert_rule_version table on rule_org_id, rule_uid and version columns	CREATE UNIQUE INDEX "UQE_alert_rule_version_rule_org_id_rule_uid_version" ON "alert_rule_version" ("rule_org_id","rule_uid","version");	t		2024-03-25 14:20:20
357	add index in alert_rule_version table on rule_org_id, rule_namespace_uid and rule_group columns	CREATE INDEX "IDX_alert_rule_version_rule_org_id_rule_namespace_uid_rule_group" ON "alert_rule_version" ("rule_org_id","rule_namespace_uid","rule_group");	t		2024-03-25 14:20:20
358	alter alert_rule_version table data column to mediumtext in mysql	SELECT 0;	t		2024-03-25 14:20:20
359	add column for to alert_rule_version	alter table "alert_rule_version" ADD COLUMN "for" BIGINT NOT NULL DEFAULT 0 	t		2024-03-25 14:20:20
360	add column annotations to alert_rule_version	alter table "alert_rule_version" ADD COLUMN "annotations" TEXT NULL 	t		2024-03-25 14:20:20
361	add column labels to alert_rule_version	alter table "alert_rule_version" ADD COLUMN "labels" TEXT NULL 	t		2024-03-25 14:20:20
362	add rule_group_idx column to alert_rule_version	alter table "alert_rule_version" ADD COLUMN "rule_group_idx" INTEGER NOT NULL DEFAULT 1 	t		2024-03-25 14:20:20
363	add is_paused column to alert_rule_versions table	alter table "alert_rule_version" ADD COLUMN "is_paused" BOOL NOT NULL DEFAULT false 	t		2024-03-25 14:20:20
364	fix is_paused column for alert_rule_version table	ALTER TABLE alert_rule_version ALTER COLUMN is_paused SET DEFAULT false;\nUPDATE alert_rule_version SET is_paused = false;	t		2024-03-25 14:20:20
365	create_alert_configuration_table	CREATE TABLE IF NOT EXISTS "alert_configuration" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "alertmanager_configuration" TEXT NOT NULL\n, "configuration_version" VARCHAR(3) NOT NULL\n, "created_at" INTEGER NOT NULL\n);	t		2024-03-25 14:20:20
366	Add column default in alert_configuration	alter table "alert_configuration" ADD COLUMN "default" BOOL NOT NULL DEFAULT false 	t		2024-03-25 14:20:20
367	alert alert_configuration alertmanager_configuration column from TEXT to MEDIUMTEXT if mysql	SELECT 0;	t		2024-03-25 14:20:20
368	add column org_id in alert_configuration	alter table "alert_configuration" ADD COLUMN "org_id" BIGINT NOT NULL DEFAULT 0 	t		2024-03-25 14:20:20
369	add index in alert_configuration table on org_id column	CREATE INDEX "IDX_alert_configuration_org_id" ON "alert_configuration" ("org_id");	t		2024-03-25 14:20:20
370	add configuration_hash column to alert_configuration	alter table "alert_configuration" ADD COLUMN "configuration_hash" VARCHAR(32) NOT NULL DEFAULT 'not-yet-calculated' 	t		2024-03-25 14:20:20
371	create_ngalert_configuration_table	CREATE TABLE IF NOT EXISTS "ngalert_configuration" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "org_id" BIGINT NOT NULL\n, "alertmanagers" TEXT NULL\n, "created_at" INTEGER NOT NULL\n, "updated_at" INTEGER NOT NULL\n);	t		2024-03-25 14:20:20
372	add index in ngalert_configuration on org_id column	CREATE UNIQUE INDEX "UQE_ngalert_configuration_org_id" ON "ngalert_configuration" ("org_id");	t		2024-03-25 14:20:20
373	add column send_alerts_to in ngalert_configuration	alter table "ngalert_configuration" ADD COLUMN "send_alerts_to" SMALLINT NOT NULL DEFAULT 0 	t		2024-03-25 14:20:20
374	create provenance_type table	CREATE TABLE IF NOT EXISTS "provenance_type" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "org_id" BIGINT NOT NULL\n, "record_key" VARCHAR(190) NOT NULL\n, "record_type" VARCHAR(190) NOT NULL\n, "provenance" VARCHAR(190) NOT NULL\n);	t		2024-03-25 14:20:20
375	add index to uniquify (record_key, record_type, org_id) columns	CREATE UNIQUE INDEX "UQE_provenance_type_record_type_record_key_org_id" ON "provenance_type" ("record_type","record_key","org_id");	t		2024-03-25 14:20:20
376	create alert_image table	CREATE TABLE IF NOT EXISTS "alert_image" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "token" VARCHAR(190) NOT NULL\n, "path" VARCHAR(190) NOT NULL\n, "url" VARCHAR(190) NOT NULL\n, "created_at" TIMESTAMP NOT NULL\n, "expires_at" TIMESTAMP NOT NULL\n);	t		2024-03-25 14:20:20
377	add unique index on token to alert_image table	CREATE UNIQUE INDEX "UQE_alert_image_token" ON "alert_image" ("token");	t		2024-03-25 14:20:20
378	support longer URLs in alert_image table	ALTER TABLE alert_image ALTER COLUMN url TYPE VARCHAR(2048);	t		2024-03-25 14:20:20
379	create_alert_configuration_history_table	CREATE TABLE IF NOT EXISTS "alert_configuration_history" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "org_id" BIGINT NOT NULL DEFAULT 0\n, "alertmanager_configuration" TEXT NOT NULL\n, "configuration_hash" VARCHAR(32) NOT NULL DEFAULT 'not-yet-calculated'\n, "configuration_version" VARCHAR(3) NOT NULL\n, "created_at" INTEGER NOT NULL\n, "default" BOOL NOT NULL DEFAULT false\n);	t		2024-03-25 14:20:20
380	drop non-unique orgID index on alert_configuration	DROP INDEX "IDX_alert_configuration_org_id" CASCADE	t		2024-03-25 14:20:20
381	drop unique orgID index on alert_configuration if exists	DROP INDEX "UQE_alert_configuration_org_id" CASCADE	t		2024-03-25 14:20:20
382	extract alertmanager configuration history to separate table	code migration	t		2024-03-25 14:20:20
383	add unique index on orgID to alert_configuration	CREATE UNIQUE INDEX "UQE_alert_configuration_org_id" ON "alert_configuration" ("org_id");	t		2024-03-25 14:20:20
384	add last_applied column to alert_configuration_history	alter table "alert_configuration_history" ADD COLUMN "last_applied" INTEGER NOT NULL DEFAULT 0 	t		2024-03-25 14:20:20
385	create library_element table v1	CREATE TABLE IF NOT EXISTS "library_element" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "org_id" BIGINT NOT NULL\n, "folder_id" BIGINT NOT NULL\n, "uid" VARCHAR(40) NOT NULL\n, "name" VARCHAR(150) NOT NULL\n, "kind" BIGINT NOT NULL\n, "type" VARCHAR(40) NOT NULL\n, "description" VARCHAR(255) NOT NULL\n, "model" TEXT NOT NULL\n, "created" TIMESTAMP NOT NULL\n, "created_by" BIGINT NOT NULL\n, "updated" TIMESTAMP NOT NULL\n, "updated_by" BIGINT NOT NULL\n, "version" BIGINT NOT NULL\n);	t		2024-03-25 14:20:20
386	add index library_element org_id-folder_id-name-kind	CREATE UNIQUE INDEX "UQE_library_element_org_id_folder_id_name_kind" ON "library_element" ("org_id","folder_id","name","kind");	t		2024-03-25 14:20:20
387	create library_element_connection table v1	CREATE TABLE IF NOT EXISTS "library_element_connection" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "element_id" BIGINT NOT NULL\n, "kind" BIGINT NOT NULL\n, "connection_id" BIGINT NOT NULL\n, "created" TIMESTAMP NOT NULL\n, "created_by" BIGINT NOT NULL\n);	t		2024-03-25 14:20:20
388	add index library_element_connection element_id-kind-connection_id	CREATE UNIQUE INDEX "UQE_library_element_connection_element_id_kind_connection_id" ON "library_element_connection" ("element_id","kind","connection_id");	t		2024-03-25 14:20:20
389	add unique index library_element org_id_uid	CREATE UNIQUE INDEX "UQE_library_element_org_id_uid" ON "library_element" ("org_id","uid");	t		2024-03-25 14:20:20
390	increase max description length to 2048	ALTER TABLE "library_element" ALTER "description" TYPE VARCHAR(2048);	t		2024-03-25 14:20:20
391	alter library_element model to mediumtext	SELECT 0;	t		2024-03-25 14:20:20
392	clone move dashboard alerts to unified alerting	code migration	t		2024-03-25 14:20:20
393	create data_keys table	CREATE TABLE IF NOT EXISTS "data_keys" (\n"name" VARCHAR(100) PRIMARY KEY NOT NULL\n, "active" BOOL NOT NULL\n, "scope" VARCHAR(30) NOT NULL\n, "provider" VARCHAR(50) NOT NULL\n, "encrypted_data" BYTEA NOT NULL\n, "created" TIMESTAMP NOT NULL\n, "updated" TIMESTAMP NOT NULL\n);	t		2024-03-25 14:20:20
394	create secrets table	CREATE TABLE IF NOT EXISTS "secrets" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "org_id" BIGINT NOT NULL\n, "namespace" VARCHAR(255) NOT NULL\n, "type" VARCHAR(255) NOT NULL\n, "value" TEXT NULL\n, "created" TIMESTAMP NOT NULL\n, "updated" TIMESTAMP NOT NULL\n);	t		2024-03-25 14:20:20
395	rename data_keys name column to id	ALTER TABLE "data_keys" RENAME COLUMN "name" TO "id"	t		2024-03-25 14:20:20
396	add name column into data_keys	alter table "data_keys" ADD COLUMN "name" VARCHAR(100) NOT NULL DEFAULT '' 	t		2024-03-25 14:20:20
397	copy data_keys id column values into name	UPDATE data_keys SET name = id	t		2024-03-25 14:20:20
398	rename data_keys name column to label	ALTER TABLE "data_keys" RENAME COLUMN "name" TO "label"	t		2024-03-25 14:20:20
399	rename data_keys id column back to name	ALTER TABLE "data_keys" RENAME COLUMN "id" TO "name"	t		2024-03-25 14:20:20
400	create kv_store table v1	CREATE TABLE IF NOT EXISTS "kv_store" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "org_id" BIGINT NOT NULL\n, "namespace" VARCHAR(190) NOT NULL\n, "key" VARCHAR(190) NOT NULL\n, "value" TEXT NOT NULL\n, "created" TIMESTAMP NOT NULL\n, "updated" TIMESTAMP NOT NULL\n);	t		2024-03-25 14:20:20
401	add index kv_store.org_id-namespace-key	CREATE UNIQUE INDEX "UQE_kv_store_org_id_namespace_key" ON "kv_store" ("org_id","namespace","key");	t		2024-03-25 14:20:20
402	update dashboard_uid and panel_id from existing annotations	set dashboard_uid and panel_id migration	t		2024-03-25 14:20:20
403	create permission table	CREATE TABLE IF NOT EXISTS "permission" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "role_id" BIGINT NOT NULL\n, "action" VARCHAR(190) NOT NULL\n, "scope" VARCHAR(190) NOT NULL\n, "created" TIMESTAMP NOT NULL\n, "updated" TIMESTAMP NOT NULL\n);	t		2024-03-25 14:20:20
404	add unique index permission.role_id	CREATE INDEX "IDX_permission_role_id" ON "permission" ("role_id");	t		2024-03-25 14:20:20
405	add unique index role_id_action_scope	CREATE UNIQUE INDEX "UQE_permission_role_id_action_scope" ON "permission" ("role_id","action","scope");	t		2024-03-25 14:20:20
406	create role table	CREATE TABLE IF NOT EXISTS "role" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "name" VARCHAR(190) NOT NULL\n, "description" TEXT NULL\n, "version" BIGINT NOT NULL\n, "org_id" BIGINT NOT NULL\n, "uid" VARCHAR(40) NOT NULL\n, "created" TIMESTAMP NOT NULL\n, "updated" TIMESTAMP NOT NULL\n);	t		2024-03-25 14:20:20
408	add column group_name	alter table "role" ADD COLUMN "group_name" VARCHAR(190) NULL 	t		2024-03-25 14:20:20
409	add index role.org_id	CREATE INDEX "IDX_role_org_id" ON "role" ("org_id");	t		2024-03-25 14:20:20
410	add unique index role_org_id_name	CREATE UNIQUE INDEX "UQE_role_org_id_name" ON "role" ("org_id","name");	t		2024-03-25 14:20:20
411	add index role_org_id_uid	CREATE UNIQUE INDEX "UQE_role_org_id_uid" ON "role" ("org_id","uid");	t		2024-03-25 14:20:20
412	create team role table	CREATE TABLE IF NOT EXISTS "team_role" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "org_id" BIGINT NOT NULL\n, "team_id" BIGINT NOT NULL\n, "role_id" BIGINT NOT NULL\n, "created" TIMESTAMP NOT NULL\n);	t		2024-03-25 14:20:20
413	add index team_role.org_id	CREATE INDEX "IDX_team_role_org_id" ON "team_role" ("org_id");	t		2024-03-25 14:20:20
414	add unique index team_role_org_id_team_id_role_id	CREATE UNIQUE INDEX "UQE_team_role_org_id_team_id_role_id" ON "team_role" ("org_id","team_id","role_id");	t		2024-03-25 14:20:20
415	add index team_role.team_id	CREATE INDEX "IDX_team_role_team_id" ON "team_role" ("team_id");	t		2024-03-25 14:20:20
416	create user role table	CREATE TABLE IF NOT EXISTS "user_role" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "org_id" BIGINT NOT NULL\n, "user_id" BIGINT NOT NULL\n, "role_id" BIGINT NOT NULL\n, "created" TIMESTAMP NOT NULL\n);	t		2024-03-25 14:20:20
417	add index user_role.org_id	CREATE INDEX "IDX_user_role_org_id" ON "user_role" ("org_id");	t		2024-03-25 14:20:20
418	add unique index user_role_org_id_user_id_role_id	CREATE UNIQUE INDEX "UQE_user_role_org_id_user_id_role_id" ON "user_role" ("org_id","user_id","role_id");	t		2024-03-25 14:20:20
419	add index user_role.user_id	CREATE INDEX "IDX_user_role_user_id" ON "user_role" ("user_id");	t		2024-03-25 14:20:20
420	create builtin role table	CREATE TABLE IF NOT EXISTS "builtin_role" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "role" VARCHAR(190) NOT NULL\n, "role_id" BIGINT NOT NULL\n, "created" TIMESTAMP NOT NULL\n, "updated" TIMESTAMP NOT NULL\n);	t		2024-03-25 14:20:20
421	add index builtin_role.role_id	CREATE INDEX "IDX_builtin_role_role_id" ON "builtin_role" ("role_id");	t		2024-03-25 14:20:20
422	add index builtin_role.name	CREATE INDEX "IDX_builtin_role_role" ON "builtin_role" ("role");	t		2024-03-25 14:20:20
423	Add column org_id to builtin_role table	alter table "builtin_role" ADD COLUMN "org_id" BIGINT NOT NULL DEFAULT 0 	t		2024-03-25 14:20:20
424	add index builtin_role.org_id	CREATE INDEX "IDX_builtin_role_org_id" ON "builtin_role" ("org_id");	t		2024-03-25 14:20:20
425	add unique index builtin_role_org_id_role_id_role	CREATE UNIQUE INDEX "UQE_builtin_role_org_id_role_id_role" ON "builtin_role" ("org_id","role_id","role");	t		2024-03-25 14:20:20
426	Remove unique index role_org_id_uid	DROP INDEX "UQE_role_org_id_uid" CASCADE	t		2024-03-25 14:20:20
427	add unique index role.uid	CREATE UNIQUE INDEX "UQE_role_uid" ON "role" ("uid");	t		2024-03-25 14:20:20
428	create seed assignment table	CREATE TABLE IF NOT EXISTS "seed_assignment" (\n"builtin_role" VARCHAR(190) NOT NULL\n, "role_name" VARCHAR(190) NOT NULL\n);	t		2024-03-25 14:20:20
429	add unique index builtin_role_role_name	CREATE UNIQUE INDEX "UQE_seed_assignment_builtin_role_role_name" ON "seed_assignment" ("builtin_role","role_name");	t		2024-03-25 14:20:20
430	add column hidden to role table	alter table "role" ADD COLUMN "hidden" BOOL NOT NULL DEFAULT false 	t		2024-03-25 14:20:20
431	permission kind migration	alter table "permission" ADD COLUMN "kind" VARCHAR(40) NOT NULL DEFAULT '' 	t		2024-03-25 14:20:20
432	permission attribute migration	alter table "permission" ADD COLUMN "attribute" VARCHAR(40) NOT NULL DEFAULT '' 	t		2024-03-25 14:20:20
433	permission identifier migration	alter table "permission" ADD COLUMN "identifier" VARCHAR(40) NOT NULL DEFAULT '' 	t		2024-03-25 14:20:20
434	add permission identifier index	CREATE INDEX "IDX_permission_identifier" ON "permission" ("identifier");	t		2024-03-25 14:20:20
435	add permission action scope role_id index	CREATE UNIQUE INDEX "UQE_permission_action_scope_role_id" ON "permission" ("action","scope","role_id");	t		2024-03-25 14:20:20
436	remove permission role_id action scope index	DROP INDEX "UQE_permission_role_id_action_scope" CASCADE	t		2024-03-25 14:20:20
437	create query_history table v1	CREATE TABLE IF NOT EXISTS "query_history" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "uid" VARCHAR(40) NOT NULL\n, "org_id" BIGINT NOT NULL\n, "datasource_uid" VARCHAR(40) NOT NULL\n, "created_by" INTEGER NOT NULL\n, "created_at" INTEGER NOT NULL\n, "comment" TEXT NOT NULL\n, "queries" TEXT NOT NULL\n);	t		2024-03-25 14:20:20
438	add index query_history.org_id-created_by-datasource_uid	CREATE INDEX "IDX_query_history_org_id_created_by_datasource_uid" ON "query_history" ("org_id","created_by","datasource_uid");	t		2024-03-25 14:20:20
439	alter table query_history alter column created_by type to bigint	ALTER TABLE query_history ALTER COLUMN created_by TYPE BIGINT;	t		2024-03-25 14:20:20
440	rbac disabled migrator	code migration	t		2024-03-25 14:20:20
441	teams permissions migration	code migration	t		2024-03-25 14:20:20
442	dashboard permissions	code migration	t		2024-03-25 14:20:20
443	dashboard permissions uid scopes	code migration	t		2024-03-25 14:20:20
444	drop managed folder create actions	code migration	t		2024-03-25 14:20:20
445	alerting notification permissions	code migration	t		2024-03-25 14:20:20
446	create query_history_star table v1	CREATE TABLE IF NOT EXISTS "query_history_star" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "query_uid" VARCHAR(40) NOT NULL\n, "user_id" INTEGER NOT NULL\n);	t		2024-03-25 14:20:20
447	add index query_history.user_id-query_uid	CREATE UNIQUE INDEX "UQE_query_history_star_user_id_query_uid" ON "query_history_star" ("user_id","query_uid");	t		2024-03-25 14:20:20
448	add column org_id in query_history_star	alter table "query_history_star" ADD COLUMN "org_id" BIGINT NOT NULL DEFAULT 1 	t		2024-03-25 14:20:20
449	alter table query_history_star_mig column user_id type to bigint	ALTER TABLE query_history_star ALTER COLUMN user_id TYPE BIGINT;	t		2024-03-25 14:20:20
450	create correlation table v1	CREATE TABLE IF NOT EXISTS "correlation" (\n"uid" VARCHAR(40) NOT NULL\n, "source_uid" VARCHAR(40) NOT NULL\n, "target_uid" VARCHAR(40) NULL\n, "label" TEXT NOT NULL\n, "description" TEXT NOT NULL\n, PRIMARY KEY ( "uid","source_uid" ));	t		2024-03-25 14:20:20
451	add index correlations.uid	CREATE INDEX "IDX_correlation_uid" ON "correlation" ("uid");	t		2024-03-25 14:20:20
452	add index correlations.source_uid	CREATE INDEX "IDX_correlation_source_uid" ON "correlation" ("source_uid");	t		2024-03-25 14:20:20
453	add correlation config column	alter table "correlation" ADD COLUMN "config" TEXT NULL 	t		2024-03-25 14:20:20
454	drop index IDX_correlation_uid - v1	DROP INDEX "IDX_correlation_uid" CASCADE	t		2024-03-25 14:20:20
455	drop index IDX_correlation_source_uid - v1	DROP INDEX "IDX_correlation_source_uid" CASCADE	t		2024-03-25 14:20:20
456	Rename table correlation to correlation_tmp_qwerty - v1	ALTER TABLE "correlation" RENAME TO "correlation_tmp_qwerty"	t		2024-03-25 14:20:20
457	create correlation v2	CREATE TABLE IF NOT EXISTS "correlation" (\n"uid" VARCHAR(40) NOT NULL\n, "org_id" BIGINT NOT NULL DEFAULT 0\n, "source_uid" VARCHAR(40) NOT NULL\n, "target_uid" VARCHAR(40) NULL\n, "label" TEXT NOT NULL\n, "description" TEXT NOT NULL\n, "config" TEXT NULL\n, PRIMARY KEY ( "uid","org_id","source_uid" ));	t		2024-03-25 14:20:20
458	create index IDX_correlation_uid - v2	CREATE INDEX "IDX_correlation_uid" ON "correlation" ("uid");	t		2024-03-25 14:20:20
459	create index IDX_correlation_source_uid - v2	CREATE INDEX "IDX_correlation_source_uid" ON "correlation" ("source_uid");	t		2024-03-25 14:20:20
460	create index IDX_correlation_org_id - v2	CREATE INDEX "IDX_correlation_org_id" ON "correlation" ("org_id");	t		2024-03-25 14:20:20
461	copy correlation v1 to v2	INSERT INTO "correlation" ("config"\n, "uid"\n, "source_uid"\n, "target_uid"\n, "label"\n, "description") SELECT "config"\n, "uid"\n, "source_uid"\n, "target_uid"\n, "label"\n, "description" FROM "correlation_tmp_qwerty"	t		2024-03-25 14:20:20
462	drop correlation_tmp_qwerty	DROP TABLE IF EXISTS "correlation_tmp_qwerty"	t		2024-03-25 14:20:20
463	add provisioning column	alter table "correlation" ADD COLUMN "provisioned" BOOL NOT NULL DEFAULT false 	t		2024-03-25 14:20:20
464	create entity_events table	CREATE TABLE IF NOT EXISTS "entity_event" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "entity_id" VARCHAR(1024) NOT NULL\n, "event_type" VARCHAR(8) NOT NULL\n, "created" BIGINT NOT NULL\n);	t		2024-03-25 14:20:20
465	create dashboard public config v1	CREATE TABLE IF NOT EXISTS "dashboard_public_config" (\n"uid" VARCHAR(40) PRIMARY KEY NOT NULL\n, "dashboard_uid" VARCHAR(40) NOT NULL\n, "org_id" BIGINT NOT NULL\n, "time_settings" TEXT NOT NULL\n, "refresh_rate" INTEGER NOT NULL DEFAULT 30\n, "template_variables" TEXT NULL\n);	t		2024-03-25 14:20:20
466	drop index UQE_dashboard_public_config_uid - v1	DROP INDEX "UQE_dashboard_public_config_uid" CASCADE	t		2024-03-25 14:20:20
467	drop index IDX_dashboard_public_config_org_id_dashboard_uid - v1	DROP INDEX "IDX_dashboard_public_config_org_id_dashboard_uid" CASCADE	t		2024-03-25 14:20:20
468	Drop old dashboard public config table	DROP TABLE IF EXISTS "dashboard_public_config"	t		2024-03-25 14:20:20
469	recreate dashboard public config v1	CREATE TABLE IF NOT EXISTS "dashboard_public_config" (\n"uid" VARCHAR(40) PRIMARY KEY NOT NULL\n, "dashboard_uid" VARCHAR(40) NOT NULL\n, "org_id" BIGINT NOT NULL\n, "time_settings" TEXT NOT NULL\n, "refresh_rate" INTEGER NOT NULL DEFAULT 30\n, "template_variables" TEXT NULL\n);	t		2024-03-25 14:20:20
470	create index UQE_dashboard_public_config_uid - v1	CREATE UNIQUE INDEX "UQE_dashboard_public_config_uid" ON "dashboard_public_config" ("uid");	t		2024-03-25 14:20:20
471	create index IDX_dashboard_public_config_org_id_dashboard_uid - v1	CREATE INDEX "IDX_dashboard_public_config_org_id_dashboard_uid" ON "dashboard_public_config" ("org_id","dashboard_uid");	t		2024-03-25 14:20:20
472	drop index UQE_dashboard_public_config_uid - v2	DROP INDEX "UQE_dashboard_public_config_uid" CASCADE	t		2024-03-25 14:20:20
473	drop index IDX_dashboard_public_config_org_id_dashboard_uid - v2	DROP INDEX "IDX_dashboard_public_config_org_id_dashboard_uid" CASCADE	t		2024-03-25 14:20:20
474	Drop public config table	DROP TABLE IF EXISTS "dashboard_public_config"	t		2024-03-25 14:20:20
475	Recreate dashboard public config v2	CREATE TABLE IF NOT EXISTS "dashboard_public_config" (\n"uid" VARCHAR(40) PRIMARY KEY NOT NULL\n, "dashboard_uid" VARCHAR(40) NOT NULL\n, "org_id" BIGINT NOT NULL\n, "time_settings" TEXT NULL\n, "template_variables" TEXT NULL\n, "access_token" VARCHAR(32) NOT NULL\n, "created_by" INTEGER NOT NULL\n, "updated_by" INTEGER NULL\n, "created_at" TIMESTAMP NOT NULL\n, "updated_at" TIMESTAMP NULL\n, "is_enabled" BOOL NOT NULL DEFAULT false\n);	t		2024-03-25 14:20:20
476	create index UQE_dashboard_public_config_uid - v2	CREATE UNIQUE INDEX "UQE_dashboard_public_config_uid" ON "dashboard_public_config" ("uid");	t		2024-03-25 14:20:20
477	create index IDX_dashboard_public_config_org_id_dashboard_uid - v2	CREATE INDEX "IDX_dashboard_public_config_org_id_dashboard_uid" ON "dashboard_public_config" ("org_id","dashboard_uid");	t		2024-03-25 14:20:20
478	create index UQE_dashboard_public_config_access_token - v2	CREATE UNIQUE INDEX "UQE_dashboard_public_config_access_token" ON "dashboard_public_config" ("access_token");	t		2024-03-25 14:20:20
479	Rename table dashboard_public_config to dashboard_public - v2	ALTER TABLE "dashboard_public_config" RENAME TO "dashboard_public"	t		2024-03-25 14:20:20
480	add annotations_enabled column	alter table "dashboard_public" ADD COLUMN "annotations_enabled" BOOL NOT NULL DEFAULT false 	t		2024-03-25 14:20:20
481	add time_selection_enabled column	alter table "dashboard_public" ADD COLUMN "time_selection_enabled" BOOL NOT NULL DEFAULT false 	t		2024-03-25 14:20:20
482	delete orphaned public dashboards	DELETE FROM dashboard_public WHERE dashboard_uid NOT IN (SELECT uid FROM dashboard)	t		2024-03-25 14:20:20
483	add share column	alter table "dashboard_public" ADD COLUMN "share" VARCHAR(64) NOT NULL DEFAULT 'public' 	t		2024-03-25 14:20:20
484	backfill empty share column fields with default of public	UPDATE dashboard_public SET share='public' WHERE share=''	t		2024-03-25 14:20:20
485	create file table	CREATE TABLE IF NOT EXISTS "file" (\n"path" VARCHAR(1024) NOT NULL\n, "path_hash" VARCHAR(64) NOT NULL\n, "parent_folder_path_hash" VARCHAR(64) NOT NULL\n, "contents" BYTEA NOT NULL\n, "etag" VARCHAR(32) NOT NULL\n, "cache_control" VARCHAR(128) NOT NULL\n, "content_disposition" VARCHAR(128) NOT NULL\n, "updated" TIMESTAMP NOT NULL\n, "created" TIMESTAMP NOT NULL\n, "size" BIGINT NOT NULL\n, "mime_type" VARCHAR(255) NOT NULL\n);	t		2024-03-25 14:20:20
486	file table idx: path natural pk	CREATE UNIQUE INDEX "UQE_file_path_hash" ON "file" ("path_hash");	t		2024-03-25 14:20:20
487	file table idx: parent_folder_path_hash fast folder retrieval	CREATE INDEX "IDX_file_parent_folder_path_hash" ON "file" ("parent_folder_path_hash");	t		2024-03-25 14:20:20
488	create file_meta table	CREATE TABLE IF NOT EXISTS "file_meta" (\n"path_hash" VARCHAR(64) NOT NULL\n, "key" VARCHAR(191) NOT NULL\n, "value" VARCHAR(1024) NOT NULL\n);	t		2024-03-25 14:20:20
489	file table idx: path key	CREATE UNIQUE INDEX "UQE_file_meta_path_hash_key" ON "file_meta" ("path_hash","key");	t		2024-03-25 14:20:20
490	set path collation in file table	ALTER TABLE file ALTER COLUMN path TYPE VARCHAR(1024) COLLATE "C";	t		2024-03-25 14:20:20
491	migrate contents column to mediumblob for MySQL	SELECT 0;	t		2024-03-25 14:20:20
492	managed permissions migration	code migration	t		2024-03-25 14:20:20
493	managed folder permissions alert actions migration	code migration	t		2024-03-25 14:20:20
494	RBAC action name migrator	code migration	t		2024-03-25 14:20:20
495	Add UID column to playlist	alter table "playlist" ADD COLUMN "uid" VARCHAR(80) NOT NULL DEFAULT 0 	t		2024-03-25 14:20:20
496	Update uid column values in playlist	UPDATE playlist SET uid=id::text;	t		2024-03-25 14:20:20
497	Add index for uid in playlist	CREATE UNIQUE INDEX "UQE_playlist_org_id_uid" ON "playlist" ("org_id","uid");	t		2024-03-25 14:20:20
498	update group index for alert rules	code migration	t		2024-03-25 14:20:20
499	managed folder permissions alert actions repeated migration	code migration	t		2024-03-25 14:20:20
500	admin only folder/dashboard permission	code migration	t		2024-03-25 14:20:20
501	add action column to seed_assignment	alter table "seed_assignment" ADD COLUMN "action" VARCHAR(190) NULL 	t		2024-03-25 14:20:20
502	add scope column to seed_assignment	alter table "seed_assignment" ADD COLUMN "scope" VARCHAR(190) NULL 	t		2024-03-25 14:20:20
503	remove unique index builtin_role_role_name before nullable update	DROP INDEX "UQE_seed_assignment_builtin_role_role_name" CASCADE	t		2024-03-25 14:20:20
504	update seed_assignment role_name column to nullable	ALTER TABLE `seed_assignment` ALTER COLUMN role_name DROP NOT NULL;	t		2024-03-25 14:20:20
505	add unique index builtin_role_name back	CREATE UNIQUE INDEX "UQE_seed_assignment_builtin_role_role_name" ON "seed_assignment" ("builtin_role","role_name");	t		2024-03-25 14:20:20
506	add unique index builtin_role_action_scope	CREATE UNIQUE INDEX "UQE_seed_assignment_builtin_role_action_scope" ON "seed_assignment" ("builtin_role","action","scope");	t		2024-03-25 14:20:20
507	add primary key to seed_assigment	code migration	t		2024-03-25 14:20:20
508	add origin column to seed_assignment	alter table "seed_assignment" ADD COLUMN "origin" VARCHAR(190) NULL 	t		2024-03-25 14:20:20
509	add origin to plugin seed_assignment	code migration	t		2024-03-25 14:20:20
510	prevent seeding OnCall access	code migration	t		2024-03-25 14:20:20
511	managed folder permissions alert actions repeated fixed migration	code migration	t		2024-03-25 14:20:20
512	managed folder permissions library panel actions migration	code migration	t		2024-03-25 14:20:20
513	migrate external alertmanagers to datsourcse	migrate external alertmanagers to datasource	t		2024-03-25 14:20:20
514	create folder table	CREATE TABLE IF NOT EXISTS "folder" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "uid" VARCHAR(40) NOT NULL\n, "org_id" BIGINT NOT NULL\n, "title" VARCHAR(255) NOT NULL\n, "description" VARCHAR(255) NULL\n, "parent_uid" VARCHAR(40) NULL\n, "created" TIMESTAMP NOT NULL\n, "updated" TIMESTAMP NOT NULL\n);	t		2024-03-25 14:20:20
515	Add index for parent_uid	CREATE INDEX "IDX_folder_parent_uid_org_id" ON "folder" ("parent_uid","org_id");	t		2024-03-25 14:20:20
516	Add unique index for folder.uid and folder.org_id	CREATE UNIQUE INDEX "UQE_folder_uid_org_id" ON "folder" ("uid","org_id");	t		2024-03-25 14:20:20
517	Update folder title length	ALTER TABLE "folder" ALTER "title" TYPE VARCHAR(189);	t		2024-03-25 14:20:20
518	Add unique index for folder.title and folder.parent_uid	CREATE UNIQUE INDEX "UQE_folder_title_parent_uid" ON "folder" ("title","parent_uid");	t		2024-03-25 14:20:20
519	Remove unique index for folder.title and folder.parent_uid	DROP INDEX "UQE_folder_title_parent_uid" CASCADE	t		2024-03-25 14:20:20
520	Add unique index for title, parent_uid, and org_id	CREATE UNIQUE INDEX "UQE_folder_title_parent_uid_org_id" ON "folder" ("title","parent_uid","org_id");	t		2024-03-25 14:20:20
521	Sync dashboard and folder table	\n\t\t\tINSERT INTO folder (uid, org_id, title, created, updated)\n\t\t\tSELECT uid, org_id, title, created, updated FROM dashboard WHERE is_folder = true\n\t\t\tON CONFLICT(uid, org_id) DO UPDATE SET title=excluded.title, updated=excluded.updated\n\t\t	t		2024-03-25 14:20:20
522	Remove ghost folders from the folder table	\n\t\t\tDELETE FROM folder WHERE NOT EXISTS\n\t\t\t\t(SELECT 1 FROM dashboard WHERE dashboard.uid = folder.uid AND dashboard.org_id = folder.org_id AND dashboard.is_folder = true)\n\t	t		2024-03-25 14:20:20
523	Remove unique index UQE_folder_uid_org_id	DROP INDEX "UQE_folder_uid_org_id" CASCADE	t		2024-03-25 14:20:20
524	Add unique index UQE_folder_org_id_uid	CREATE UNIQUE INDEX "UQE_folder_org_id_uid" ON "folder" ("org_id","uid");	t		2024-03-25 14:20:20
525	Remove unique index UQE_folder_title_parent_uid_org_id	DROP INDEX "UQE_folder_title_parent_uid_org_id" CASCADE	t		2024-03-25 14:20:20
526	Add unique index UQE_folder_org_id_parent_uid_title	CREATE UNIQUE INDEX "UQE_folder_org_id_parent_uid_title" ON "folder" ("org_id","parent_uid","title");	t		2024-03-25 14:20:20
527	Remove index IDX_folder_parent_uid_org_id	DROP INDEX "IDX_folder_parent_uid_org_id" CASCADE	t		2024-03-25 14:20:20
528	create anon_device table	CREATE TABLE IF NOT EXISTS "anon_device" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "client_ip" VARCHAR(255) NOT NULL\n, "created_at" TIMESTAMP NOT NULL\n, "device_id" VARCHAR(127) NOT NULL\n, "updated_at" TIMESTAMP NOT NULL\n, "user_agent" VARCHAR(255) NOT NULL\n);	t		2024-03-25 14:20:20
529	add unique index anon_device.device_id	CREATE UNIQUE INDEX "UQE_anon_device_device_id" ON "anon_device" ("device_id");	t		2024-03-25 14:20:20
530	add index anon_device.updated_at	CREATE INDEX "IDX_anon_device_updated_at" ON "anon_device" ("updated_at");	t		2024-03-25 14:20:20
531	create signing_key table	CREATE TABLE IF NOT EXISTS "signing_key" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "key_id" VARCHAR(255) NOT NULL\n, "private_key" TEXT NOT NULL\n, "added_at" TIMESTAMP NOT NULL\n, "expires_at" TIMESTAMP NULL\n, "alg" VARCHAR(255) NOT NULL\n);	t		2024-03-25 14:20:20
532	add unique index signing_key.key_id	CREATE UNIQUE INDEX "UQE_signing_key_key_id" ON "signing_key" ("key_id");	t		2024-03-25 14:20:20
533	set legacy alert migration status in kvstore	code migration	t		2024-03-25 14:20:20
534	migrate record of created folders during legacy migration to kvstore	code migration	t		2024-03-25 14:20:20
535	Add folder_uid for dashboard	alter table "dashboard" ADD COLUMN "folder_uid" VARCHAR(40) NULL 	t		2024-03-25 14:20:20
536	Populate dashboard folder_uid column	code migration	t		2024-03-25 14:20:20
537	Add unique index for dashboard_org_id_folder_uid_title	CREATE UNIQUE INDEX "UQE_dashboard_org_id_folder_uid_title" ON "dashboard" ("org_id","folder_uid","title");	t		2024-03-25 14:20:20
538	Delete unique index for dashboard_org_id_folder_id_title	DROP INDEX "UQE_dashboard_org_id_folder_id_title" CASCADE	t		2024-03-25 14:20:20
539	Delete unique index for dashboard_org_id_folder_uid_title	DROP INDEX "UQE_dashboard_org_id_folder_uid_title" CASCADE	t		2024-03-25 14:20:20
540	Add unique index for dashboard_org_id_folder_uid_title_is_folder	CREATE UNIQUE INDEX "UQE_dashboard_org_id_folder_uid_title_is_folder" ON "dashboard" ("org_id","folder_uid","title","is_folder");	t		2024-03-25 14:20:20
541	Restore index for dashboard_org_id_folder_id_title	CREATE INDEX "IDX_dashboard_org_id_folder_id_title" ON "dashboard" ("org_id","folder_id","title");	t		2024-03-25 14:20:20
542	create sso_setting table	CREATE TABLE IF NOT EXISTS "sso_setting" (\n"id" VARCHAR(40) PRIMARY KEY NOT NULL\n, "provider" VARCHAR(255) NOT NULL\n, "settings" TEXT NOT NULL\n, "created" TIMESTAMP NOT NULL\n, "updated" TIMESTAMP NOT NULL\n, "is_deleted" BOOL NOT NULL DEFAULT false\n);	t		2024-03-25 14:20:20
543	copy kvstore migration status to each org	code migration	t		2024-03-25 14:20:20
544	add back entry for orgid=0 migrated status	code migration	t		2024-03-25 14:20:20
545	alter kv_store.value to longtext	SELECT 0;	t		2024-03-25 14:20:20
546	add notification_settings column to alert_rule table	alter table "alert_rule" ADD COLUMN "notification_settings" TEXT NULL 	t		2024-03-25 14:20:20
547	add notification_settings column to alert_rule_version table	alter table "alert_rule_version" ADD COLUMN "notification_settings" TEXT NULL 	t		2024-03-25 14:20:20
548	removing scope from alert.instances:read action migration	code migration	t		2024-03-25 14:20:20
\.


--
-- Data for Name: ngalert_configuration; Type: TABLE DATA; Schema: public; Owner: grafana
--

COPY public.ngalert_configuration (id, org_id, alertmanagers, created_at, updated_at, send_alerts_to) FROM stdin;
\.


--
-- Data for Name: org; Type: TABLE DATA; Schema: public; Owner: grafana
--

COPY public.org (id, version, name, address1, address2, city, state, zip_code, country, billing_email, created,
                 updated) FROM stdin;
1	0	Main Org.							\N	2024-03-25 14:20:20	2024-03-25 14:20:20
\.


--
-- Data for Name: org_user; Type: TABLE DATA; Schema: public; Owner: grafana
--

COPY public.org_user (id, org_id, user_id, role, created, updated) FROM stdin;
1	1	1	Admin	2024-03-25 14:20:20	2024-03-25 14:20:20
\.


--
-- Data for Name: permission; Type: TABLE DATA; Schema: public; Owner: grafana
--

COPY public.permission (id, role_id, action, scope, created, updated, kind, attribute, identifier) FROM stdin;
\.


--
-- Data for Name: playlist; Type: TABLE DATA; Schema: public; Owner: grafana
--

COPY public.playlist (id, name, "interval", org_id, created_at, updated_at, uid) FROM stdin;
\.


--
-- Data for Name: playlist_item; Type: TABLE DATA; Schema: public; Owner: grafana
--

COPY public.playlist_item (id, playlist_id, type, value, title, "order") FROM stdin;
\.


--
-- Data for Name: plugin_setting; Type: TABLE DATA; Schema: public; Owner: grafana
--

COPY public.plugin_setting (id, org_id, plugin_id, enabled, pinned, json_data, secure_json_data, created, updated,
                            plugin_version) FROM stdin;
\.


--
-- Data for Name: preferences; Type: TABLE DATA; Schema: public; Owner: grafana
--

COPY public.preferences (id, org_id, user_id, version, home_dashboard_id, timezone, theme, created, updated, team_id,
                         week_start, json_data) FROM stdin;
\.


--
-- Data for Name: provenance_type; Type: TABLE DATA; Schema: public; Owner: grafana
--

COPY public.provenance_type (id, org_id, record_key, record_type, provenance) FROM stdin;
\.


--
-- Data for Name: query_history; Type: TABLE DATA; Schema: public; Owner: grafana
--

COPY public.query_history (id, uid, org_id, datasource_uid, created_by, created_at, comment, queries) FROM stdin;
\.


--
-- Data for Name: query_history_star; Type: TABLE DATA; Schema: public; Owner: grafana
--

COPY public.query_history_star (id, query_uid, user_id, org_id) FROM stdin;
\.


--
-- Data for Name: quota; Type: TABLE DATA; Schema: public; Owner: grafana
--

COPY public.quota (id, org_id, user_id, target, "limit", created, updated) FROM stdin;
\.


--
-- Data for Name: role; Type: TABLE DATA; Schema: public; Owner: grafana
--

COPY public.role (id, name, description, version, org_id, uid, created, updated, display_name, group_name,
                  hidden) FROM stdin;
\.


--
-- Data for Name: secrets; Type: TABLE DATA; Schema: public; Owner: grafana
--

COPY public.secrets (id, org_id, namespace, type, value, created, updated) FROM stdin;
\.


--
-- Data for Name: seed_assignment; Type: TABLE DATA; Schema: public; Owner: grafana
--

COPY public.seed_assignment (builtin_role, role_name, action, scope, id, origin) FROM stdin;
\.


--
-- Data for Name: server_lock; Type: TABLE DATA; Schema: public; Owner: grafana
--

COPY public.server_lock (id, operation_uid, version, last_execution) FROM stdin;
2	cleanup expired auth tokens	1	1711376420
4	delete old login attempts	3	1711380129
\.


--
-- Data for Name: session; Type: TABLE DATA; Schema: public; Owner: grafana
--

COPY public.session (key, data, expiry) FROM stdin;
\.


--
-- Data for Name: short_url; Type: TABLE DATA; Schema: public; Owner: grafana
--

COPY public.short_url (id, org_id, uid, path, created_by, created_at, last_seen_at) FROM stdin;
\.


--
-- Data for Name: signing_key; Type: TABLE DATA; Schema: public; Owner: grafana
--

COPY public.signing_key (id, key_id, private_key, added_at, expires_at, alg) FROM stdin;
\.


--
-- Data for Name: sso_setting; Type: TABLE DATA; Schema: public; Owner: grafana
--

COPY public.sso_setting (id, provider, settings, created, updated, is_deleted) FROM stdin;
\.


--
-- Data for Name: star; Type: TABLE DATA; Schema: public; Owner: grafana
--

COPY public.star (id, user_id, dashboard_id) FROM stdin;
\.


--
-- Data for Name: tag; Type: TABLE DATA; Schema: public; Owner: grafana
--

COPY public.tag (id, key, value) FROM stdin;
\.


--
-- Data for Name: team; Type: TABLE DATA; Schema: public; Owner: grafana
--

COPY public.team (id, name, org_id, created, updated, uid, email) FROM stdin;
\.


--
-- Data for Name: team_member; Type: TABLE DATA; Schema: public; Owner: grafana
--

COPY public.team_member (id, org_id, team_id, user_id, created, updated, external, permission) FROM stdin;
\.


--
-- Data for Name: team_role; Type: TABLE DATA; Schema: public; Owner: grafana
--

COPY public.team_role (id, org_id, team_id, role_id, created) FROM stdin;
\.


--
-- Data for Name: temp_user; Type: TABLE DATA; Schema: public; Owner: grafana
--

COPY public.temp_user (id, org_id, version, email, name, role, code, status, invited_by_user_id, email_sent,
                       email_sent_on, remote_addr, created, updated) FROM stdin;
\.


--
-- Data for Name: test_data; Type: TABLE DATA; Schema: public; Owner: grafana
--

COPY public.test_data (id, metric1, metric2, value_big_int, value_double, value_float, value_int, time_epoch,
                       time_date_time, time_time_stamp) FROM stdin;
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: grafana
--

COPY public."user" (id, version, login, email, name, password, salt, rands, company, org_id, is_admin, email_verified,
                    theme, created, updated, help_flags1, last_seen_at, is_disabled, is_service_account,
                    uid) FROM stdin;
1	0	admin	admin@localhost		e35036e6bc4b958322c6ffd29d2431cd1fc1f07492e3cf80e15c82aed9060694c34c724841c140eb59dfa484bbf6e8fad7e2	DomwbrpoA0	qlYFC7usQT		1	t	f		2024-03-25 14:20:20	2024-03-25 14:20:20	0	2014-03-25 14:20:20	f	f	
\.


--
-- Data for Name: user_auth; Type: TABLE DATA; Schema: public; Owner: grafana
--

COPY public.user_auth (id, user_id, auth_module, auth_id, created, o_auth_access_token, o_auth_refresh_token,
                       o_auth_token_type, o_auth_expiry, o_auth_id_token) FROM stdin;
\.


--
-- Data for Name: user_auth_token; Type: TABLE DATA; Schema: public; Owner: grafana
--

COPY public.user_auth_token (id, user_id, auth_token, prev_auth_token, user_agent, client_ip, auth_token_seen, seen_at,
                             rotated_at, created_at, updated_at, revoked_at) FROM stdin;
\.


--
-- Data for Name: user_role; Type: TABLE DATA; Schema: public; Owner: grafana
--

COPY public.user_role (id, org_id, user_id, role_id, created) FROM stdin;
\.


--
-- Name: alert_configuration_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana
--

SELECT pg_catalog.setval('public.alert_configuration_history_id_seq', 1, true);


--
-- Name: alert_configuration_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana
--

SELECT pg_catalog.setval('public.alert_configuration_id_seq', 1, true);


--
-- Name: alert_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana
--

SELECT pg_catalog.setval('public.alert_id_seq', 1, false);


--
-- Name: alert_image_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana
--

SELECT pg_catalog.setval('public.alert_image_id_seq', 1, false);


--
-- Name: alert_notification_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana
--

SELECT pg_catalog.setval('public.alert_notification_id_seq', 1, false);


--
-- Name: alert_notification_state_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana
--

SELECT pg_catalog.setval('public.alert_notification_state_id_seq', 1, false);


--
-- Name: alert_rule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana
--

SELECT pg_catalog.setval('public.alert_rule_id_seq', 1, false);


--
-- Name: alert_rule_tag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana
--

SELECT pg_catalog.setval('public.alert_rule_tag_id_seq', 1, false);


--
-- Name: alert_rule_version_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana
--

SELECT pg_catalog.setval('public.alert_rule_version_id_seq', 1, false);


--
-- Name: annotation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana
--

SELECT pg_catalog.setval('public.annotation_id_seq', 1, false);


--
-- Name: annotation_tag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana
--

SELECT pg_catalog.setval('public.annotation_tag_id_seq', 1, false);


--
-- Name: anon_device_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana
--

SELECT pg_catalog.setval('public.anon_device_id_seq', 1, false);


--
-- Name: api_key_id_seq1; Type: SEQUENCE SET; Schema: public; Owner: grafana
--

SELECT pg_catalog.setval('public.api_key_id_seq1', 1, false);


--
-- Name: builtin_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana
--

SELECT pg_catalog.setval('public.builtin_role_id_seq', 1, false);


--
-- Name: dashboard_acl_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana
--

SELECT pg_catalog.setval('public.dashboard_acl_id_seq', 2, true);


--
-- Name: dashboard_id_seq1; Type: SEQUENCE SET; Schema: public; Owner: grafana
--

SELECT pg_catalog.setval('public.dashboard_id_seq1', 1, false);


--
-- Name: dashboard_provisioning_id_seq1; Type: SEQUENCE SET; Schema: public; Owner: grafana
--

SELECT pg_catalog.setval('public.dashboard_provisioning_id_seq1', 1, false);


--
-- Name: dashboard_snapshot_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana
--

SELECT pg_catalog.setval('public.dashboard_snapshot_id_seq', 1, false);


--
-- Name: dashboard_tag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana
--

SELECT pg_catalog.setval('public.dashboard_tag_id_seq', 1, false);


--
-- Name: dashboard_version_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana
--

SELECT pg_catalog.setval('public.dashboard_version_id_seq', 1, false);


--
-- Name: data_source_id_seq1; Type: SEQUENCE SET; Schema: public; Owner: grafana
--

SELECT pg_catalog.setval('public.data_source_id_seq1', 1, false);


--
-- Name: entity_event_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana
--

SELECT pg_catalog.setval('public.entity_event_id_seq', 1, false);


--
-- Name: folder_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana
--

SELECT pg_catalog.setval('public.folder_id_seq', 1, false);


--
-- Name: kv_store_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana
--

SELECT pg_catalog.setval('public.kv_store_id_seq', 8, true);


--
-- Name: library_element_connection_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana
--

SELECT pg_catalog.setval('public.library_element_connection_id_seq', 1, false);


--
-- Name: library_element_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana
--

SELECT pg_catalog.setval('public.library_element_id_seq', 1, false);


--
-- Name: login_attempt_id_seq1; Type: SEQUENCE SET; Schema: public; Owner: grafana
--

SELECT pg_catalog.setval('public.login_attempt_id_seq1', 1, false);


--
-- Name: migration_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana
--

SELECT pg_catalog.setval('public.migration_log_id_seq', 548, true);


--
-- Name: ngalert_configuration_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana
--

SELECT pg_catalog.setval('public.ngalert_configuration_id_seq', 1, false);


--
-- Name: org_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana
--

SELECT pg_catalog.setval('public.org_id_seq', 1, true);


--
-- Name: org_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana
--

SELECT pg_catalog.setval('public.org_user_id_seq', 1, true);


--
-- Name: permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana
--

SELECT pg_catalog.setval('public.permission_id_seq', 1, false);


--
-- Name: playlist_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana
--

SELECT pg_catalog.setval('public.playlist_id_seq', 1, false);


--
-- Name: playlist_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana
--

SELECT pg_catalog.setval('public.playlist_item_id_seq', 1, false);


--
-- Name: plugin_setting_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana
--

SELECT pg_catalog.setval('public.plugin_setting_id_seq', 1, false);


--
-- Name: preferences_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana
--

SELECT pg_catalog.setval('public.preferences_id_seq', 1, false);


--
-- Name: provenance_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana
--

SELECT pg_catalog.setval('public.provenance_type_id_seq', 1, false);


--
-- Name: query_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana
--

SELECT pg_catalog.setval('public.query_history_id_seq', 1, false);


--
-- Name: query_history_star_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana
--

SELECT pg_catalog.setval('public.query_history_star_id_seq', 1, false);


--
-- Name: quota_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana
--

SELECT pg_catalog.setval('public.quota_id_seq', 1, false);


--
-- Name: role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana
--

SELECT pg_catalog.setval('public.role_id_seq', 1, false);


--
-- Name: secrets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana
--

SELECT pg_catalog.setval('public.secrets_id_seq', 1, false);


--
-- Name: seed_assignment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana
--

SELECT pg_catalog.setval('public.seed_assignment_id_seq', 1, false);


--
-- Name: server_lock_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana
--

SELECT pg_catalog.setval('public.server_lock_id_seq', 8, true);


--
-- Name: short_url_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana
--

SELECT pg_catalog.setval('public.short_url_id_seq', 1, false);


--
-- Name: signing_key_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana
--

SELECT pg_catalog.setval('public.signing_key_id_seq', 1, false);


--
-- Name: star_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana
--

SELECT pg_catalog.setval('public.star_id_seq', 1, false);


--
-- Name: tag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana
--

SELECT pg_catalog.setval('public.tag_id_seq', 1, false);


--
-- Name: team_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana
--

SELECT pg_catalog.setval('public.team_id_seq', 1, false);


--
-- Name: team_member_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana
--

SELECT pg_catalog.setval('public.team_member_id_seq', 1, false);


--
-- Name: team_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana
--

SELECT pg_catalog.setval('public.team_role_id_seq', 1, false);


--
-- Name: temp_user_id_seq1; Type: SEQUENCE SET; Schema: public; Owner: grafana
--

SELECT pg_catalog.setval('public.temp_user_id_seq1', 1, false);


--
-- Name: test_data_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana
--

SELECT pg_catalog.setval('public.test_data_id_seq', 1, false);


--
-- Name: user_auth_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana
--

SELECT pg_catalog.setval('public.user_auth_id_seq', 1, false);


--
-- Name: user_auth_token_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana
--

SELECT pg_catalog.setval('public.user_auth_token_id_seq', 1, false);


--
-- Name: user_id_seq1; Type: SEQUENCE SET; Schema: public; Owner: grafana
--

SELECT pg_catalog.setval('public.user_id_seq1', 1, true);


--
-- Name: user_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana
--

SELECT pg_catalog.setval('public.user_role_id_seq', 1, false);


--
-- Name: alert_configuration_history alert_configuration_history_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.alert_configuration_history
    ADD CONSTRAINT alert_configuration_history_pkey PRIMARY KEY (id);


--
-- Name: alert_configuration alert_configuration_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.alert_configuration
    ADD CONSTRAINT alert_configuration_pkey PRIMARY KEY (id);


--
-- Name: alert_image alert_image_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.alert_image
    ADD CONSTRAINT alert_image_pkey PRIMARY KEY (id);


--
-- Name: alert_instance alert_instance_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.alert_instance
    ADD CONSTRAINT alert_instance_pkey PRIMARY KEY (rule_org_id, rule_uid, labels_hash);


--
-- Name: alert_notification alert_notification_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.alert_notification
    ADD CONSTRAINT alert_notification_pkey PRIMARY KEY (id);


--
-- Name: alert_notification_state alert_notification_state_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.alert_notification_state
    ADD CONSTRAINT alert_notification_state_pkey PRIMARY KEY (id);


--
-- Name: alert alert_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.alert
    ADD CONSTRAINT alert_pkey PRIMARY KEY (id);


--
-- Name: alert_rule alert_rule_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.alert_rule
    ADD CONSTRAINT alert_rule_pkey PRIMARY KEY (id);


--
-- Name: alert_rule_tag alert_rule_tag_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.alert_rule_tag
    ADD CONSTRAINT alert_rule_tag_pkey PRIMARY KEY (id);


--
-- Name: alert_rule_version alert_rule_version_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.alert_rule_version
    ADD CONSTRAINT alert_rule_version_pkey PRIMARY KEY (id);


--
-- Name: annotation annotation_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.annotation
    ADD CONSTRAINT annotation_pkey PRIMARY KEY (id);


--
-- Name: annotation_tag annotation_tag_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.annotation_tag
    ADD CONSTRAINT annotation_tag_pkey PRIMARY KEY (id);


--
-- Name: anon_device anon_device_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.anon_device
    ADD CONSTRAINT anon_device_pkey PRIMARY KEY (id);


--
-- Name: api_key api_key_pkey1; Type: CONSTRAINT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.api_key
    ADD CONSTRAINT api_key_pkey1 PRIMARY KEY (id);


--
-- Name: builtin_role builtin_role_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.builtin_role
    ADD CONSTRAINT builtin_role_pkey PRIMARY KEY (id);


--
-- Name: cache_data cache_data_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.cache_data
    ADD CONSTRAINT cache_data_pkey PRIMARY KEY (cache_key);


--
-- Name: correlation correlation_pkey1; Type: CONSTRAINT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.correlation
    ADD CONSTRAINT correlation_pkey1 PRIMARY KEY (uid, org_id, source_uid);


--
-- Name: dashboard_acl dashboard_acl_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.dashboard_acl
    ADD CONSTRAINT dashboard_acl_pkey PRIMARY KEY (id);


--
-- Name: dashboard dashboard_pkey1; Type: CONSTRAINT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.dashboard
    ADD CONSTRAINT dashboard_pkey1 PRIMARY KEY (id);


--
-- Name: dashboard_provisioning dashboard_provisioning_pkey1; Type: CONSTRAINT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.dashboard_provisioning
    ADD CONSTRAINT dashboard_provisioning_pkey1 PRIMARY KEY (id);


--
-- Name: dashboard_public dashboard_public_config_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.dashboard_public
    ADD CONSTRAINT dashboard_public_config_pkey PRIMARY KEY (uid);


--
-- Name: dashboard_snapshot dashboard_snapshot_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.dashboard_snapshot
    ADD CONSTRAINT dashboard_snapshot_pkey PRIMARY KEY (id);


--
-- Name: dashboard_tag dashboard_tag_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.dashboard_tag
    ADD CONSTRAINT dashboard_tag_pkey PRIMARY KEY (id);


--
-- Name: dashboard_version dashboard_version_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.dashboard_version
    ADD CONSTRAINT dashboard_version_pkey PRIMARY KEY (id);


--
-- Name: data_keys data_keys_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.data_keys
    ADD CONSTRAINT data_keys_pkey PRIMARY KEY (name);


--
-- Name: data_source data_source_pkey1; Type: CONSTRAINT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.data_source
    ADD CONSTRAINT data_source_pkey1 PRIMARY KEY (id);


--
-- Name: entity_event entity_event_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.entity_event
    ADD CONSTRAINT entity_event_pkey PRIMARY KEY (id);


--
-- Name: folder folder_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.folder
    ADD CONSTRAINT folder_pkey PRIMARY KEY (id);


--
-- Name: kv_store kv_store_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.kv_store
    ADD CONSTRAINT kv_store_pkey PRIMARY KEY (id);


--
-- Name: library_element_connection library_element_connection_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.library_element_connection
    ADD CONSTRAINT library_element_connection_pkey PRIMARY KEY (id);


--
-- Name: library_element library_element_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.library_element
    ADD CONSTRAINT library_element_pkey PRIMARY KEY (id);


--
-- Name: login_attempt login_attempt_pkey1; Type: CONSTRAINT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.login_attempt
    ADD CONSTRAINT login_attempt_pkey1 PRIMARY KEY (id);


--
-- Name: migration_log migration_log_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.migration_log
    ADD CONSTRAINT migration_log_pkey PRIMARY KEY (id);


--
-- Name: ngalert_configuration ngalert_configuration_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.ngalert_configuration
    ADD CONSTRAINT ngalert_configuration_pkey PRIMARY KEY (id);


--
-- Name: org org_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT org_pkey PRIMARY KEY (id);


--
-- Name: org_user org_user_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.org_user
    ADD CONSTRAINT org_user_pkey PRIMARY KEY (id);


--
-- Name: permission permission_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.permission
    ADD CONSTRAINT permission_pkey PRIMARY KEY (id);


--
-- Name: playlist_item playlist_item_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.playlist_item
    ADD CONSTRAINT playlist_item_pkey PRIMARY KEY (id);


--
-- Name: playlist playlist_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.playlist
    ADD CONSTRAINT playlist_pkey PRIMARY KEY (id);


--
-- Name: plugin_setting plugin_setting_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.plugin_setting
    ADD CONSTRAINT plugin_setting_pkey PRIMARY KEY (id);


--
-- Name: preferences preferences_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.preferences
    ADD CONSTRAINT preferences_pkey PRIMARY KEY (id);


--
-- Name: provenance_type provenance_type_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.provenance_type
    ADD CONSTRAINT provenance_type_pkey PRIMARY KEY (id);


--
-- Name: query_history query_history_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.query_history
    ADD CONSTRAINT query_history_pkey PRIMARY KEY (id);


--
-- Name: query_history_star query_history_star_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.query_history_star
    ADD CONSTRAINT query_history_star_pkey PRIMARY KEY (id);


--
-- Name: quota quota_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.quota
    ADD CONSTRAINT quota_pkey PRIMARY KEY (id);


--
-- Name: role role_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.role
    ADD CONSTRAINT role_pkey PRIMARY KEY (id);


--
-- Name: secrets secrets_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.secrets
    ADD CONSTRAINT secrets_pkey PRIMARY KEY (id);


--
-- Name: seed_assignment seed_assignment_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.seed_assignment
    ADD CONSTRAINT seed_assignment_pkey PRIMARY KEY (id);


--
-- Name: server_lock server_lock_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.server_lock
    ADD CONSTRAINT server_lock_pkey PRIMARY KEY (id);


--
-- Name: session session_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.session
    ADD CONSTRAINT session_pkey PRIMARY KEY (key);


--
-- Name: short_url short_url_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.short_url
    ADD CONSTRAINT short_url_pkey PRIMARY KEY (id);


--
-- Name: signing_key signing_key_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.signing_key
    ADD CONSTRAINT signing_key_pkey PRIMARY KEY (id);


--
-- Name: sso_setting sso_setting_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.sso_setting
    ADD CONSTRAINT sso_setting_pkey PRIMARY KEY (id);


--
-- Name: star star_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_pkey PRIMARY KEY (id);


--
-- Name: tag tag_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.tag
    ADD CONSTRAINT tag_pkey PRIMARY KEY (id);


--
-- Name: team_member team_member_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.team_member
    ADD CONSTRAINT team_member_pkey PRIMARY KEY (id);


--
-- Name: team team_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.team
    ADD CONSTRAINT team_pkey PRIMARY KEY (id);


--
-- Name: team_role team_role_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.team_role
    ADD CONSTRAINT team_role_pkey PRIMARY KEY (id);


--
-- Name: temp_user temp_user_pkey1; Type: CONSTRAINT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.temp_user
    ADD CONSTRAINT temp_user_pkey1 PRIMARY KEY (id);


--
-- Name: test_data test_data_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.test_data
    ADD CONSTRAINT test_data_pkey PRIMARY KEY (id);


--
-- Name: user_auth user_auth_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.user_auth
    ADD CONSTRAINT user_auth_pkey PRIMARY KEY (id);


--
-- Name: user_auth_token user_auth_token_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.user_auth_token
    ADD CONSTRAINT user_auth_token_pkey PRIMARY KEY (id);


--
-- Name: user user_pkey1; Type: CONSTRAINT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey1 PRIMARY KEY (id);


--
-- Name: user_role user_role_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana
--

ALTER TABLE ONLY public.user_role
    ADD CONSTRAINT user_role_pkey PRIMARY KEY (id);


--
-- Name: IDX_alert_dashboard_id; Type: INDEX; Schema: public; Owner: grafana
--

CREATE INDEX "IDX_alert_dashboard_id" ON public.alert USING btree (dashboard_id);


--
-- Name: IDX_alert_instance_rule_org_id_current_state; Type: INDEX; Schema: public; Owner: grafana
--

CREATE INDEX "IDX_alert_instance_rule_org_id_current_state" ON public.alert_instance USING btree (rule_org_id, current_state);


--
-- Name: IDX_alert_instance_rule_org_id_rule_uid_current_state; Type: INDEX; Schema: public; Owner: grafana
--

CREATE INDEX "IDX_alert_instance_rule_org_id_rule_uid_current_state" ON public.alert_instance USING btree (rule_org_id, rule_uid, current_state);


--
-- Name: IDX_alert_notification_state_alert_id; Type: INDEX; Schema: public; Owner: grafana
--

CREATE INDEX "IDX_alert_notification_state_alert_id" ON public.alert_notification_state USING btree (alert_id);


--
-- Name: IDX_alert_org_id_id; Type: INDEX; Schema: public; Owner: grafana
--

CREATE INDEX "IDX_alert_org_id_id" ON public.alert USING btree (org_id, id);


--
-- Name: IDX_alert_rule_org_id_dashboard_uid_panel_id; Type: INDEX; Schema: public; Owner: grafana
--

CREATE INDEX "IDX_alert_rule_org_id_dashboard_uid_panel_id" ON public.alert_rule USING btree (org_id, dashboard_uid, panel_id);


--
-- Name: IDX_alert_rule_org_id_namespace_uid_rule_group; Type: INDEX; Schema: public; Owner: grafana
--

CREATE INDEX "IDX_alert_rule_org_id_namespace_uid_rule_group" ON public.alert_rule USING btree (org_id, namespace_uid, rule_group);


--
-- Name: IDX_alert_rule_tag_alert_id; Type: INDEX; Schema: public; Owner: grafana
--

CREATE INDEX "IDX_alert_rule_tag_alert_id" ON public.alert_rule_tag USING btree (alert_id);


--
-- Name: IDX_alert_rule_version_rule_org_id_rule_namespace_uid_rule_grou; Type: INDEX; Schema: public; Owner: grafana
--

CREATE INDEX "IDX_alert_rule_version_rule_org_id_rule_namespace_uid_rule_grou" ON public.alert_rule_version USING btree (rule_org_id, rule_namespace_uid, rule_group);


--
-- Name: IDX_alert_state; Type: INDEX; Schema: public; Owner: grafana
--

CREATE INDEX "IDX_alert_state" ON public.alert USING btree (state);


--
-- Name: IDX_annotation_alert_id; Type: INDEX; Schema: public; Owner: grafana
--

CREATE INDEX "IDX_annotation_alert_id" ON public.annotation USING btree (alert_id);


--
-- Name: IDX_annotation_org_id_alert_id; Type: INDEX; Schema: public; Owner: grafana
--

CREATE INDEX "IDX_annotation_org_id_alert_id" ON public.annotation USING btree (org_id, alert_id);


--
-- Name: IDX_annotation_org_id_created; Type: INDEX; Schema: public; Owner: grafana
--

CREATE INDEX "IDX_annotation_org_id_created" ON public.annotation USING btree (org_id, created);


--
-- Name: IDX_annotation_org_id_dashboard_id_epoch_end_epoch; Type: INDEX; Schema: public; Owner: grafana
--

CREATE INDEX "IDX_annotation_org_id_dashboard_id_epoch_end_epoch" ON public.annotation USING btree (org_id, dashboard_id, epoch_end, epoch);


--
-- Name: IDX_annotation_org_id_epoch_end_epoch; Type: INDEX; Schema: public; Owner: grafana
--

CREATE INDEX "IDX_annotation_org_id_epoch_end_epoch" ON public.annotation USING btree (org_id, epoch_end, epoch);


--
-- Name: IDX_annotation_org_id_type; Type: INDEX; Schema: public; Owner: grafana
--

CREATE INDEX "IDX_annotation_org_id_type" ON public.annotation USING btree (org_id, type);


--
-- Name: IDX_annotation_org_id_updated; Type: INDEX; Schema: public; Owner: grafana
--

CREATE INDEX "IDX_annotation_org_id_updated" ON public.annotation USING btree (org_id, updated);


--
-- Name: IDX_anon_device_updated_at; Type: INDEX; Schema: public; Owner: grafana
--

CREATE INDEX "IDX_anon_device_updated_at" ON public.anon_device USING btree (updated_at);


--
-- Name: IDX_api_key_org_id; Type: INDEX; Schema: public; Owner: grafana
--

CREATE INDEX "IDX_api_key_org_id" ON public.api_key USING btree (org_id);


--
-- Name: IDX_builtin_role_org_id; Type: INDEX; Schema: public; Owner: grafana
--

CREATE INDEX "IDX_builtin_role_org_id" ON public.builtin_role USING btree (org_id);


--
-- Name: IDX_builtin_role_role; Type: INDEX; Schema: public; Owner: grafana
--

CREATE INDEX "IDX_builtin_role_role" ON public.builtin_role USING btree (role);


--
-- Name: IDX_builtin_role_role_id; Type: INDEX; Schema: public; Owner: grafana
--

CREATE INDEX "IDX_builtin_role_role_id" ON public.builtin_role USING btree (role_id);


--
-- Name: IDX_correlation_org_id; Type: INDEX; Schema: public; Owner: grafana
--

CREATE INDEX "IDX_correlation_org_id" ON public.correlation USING btree (org_id);


--
-- Name: IDX_correlation_source_uid; Type: INDEX; Schema: public; Owner: grafana
--

CREATE INDEX "IDX_correlation_source_uid" ON public.correlation USING btree (source_uid);


--
-- Name: IDX_correlation_uid; Type: INDEX; Schema: public; Owner: grafana
--

CREATE INDEX "IDX_correlation_uid" ON public.correlation USING btree (uid);


--
-- Name: IDX_dashboard_acl_dashboard_id; Type: INDEX; Schema: public; Owner: grafana
--

CREATE INDEX "IDX_dashboard_acl_dashboard_id" ON public.dashboard_acl USING btree (dashboard_id);


--
-- Name: IDX_dashboard_acl_org_id_role; Type: INDEX; Schema: public; Owner: grafana
--

CREATE INDEX "IDX_dashboard_acl_org_id_role" ON public.dashboard_acl USING btree (org_id, role);


--
-- Name: IDX_dashboard_acl_permission; Type: INDEX; Schema: public; Owner: grafana
--

CREATE INDEX "IDX_dashboard_acl_permission" ON public.dashboard_acl USING btree (permission);


--
-- Name: IDX_dashboard_acl_team_id; Type: INDEX; Schema: public; Owner: grafana
--

CREATE INDEX "IDX_dashboard_acl_team_id" ON public.dashboard_acl USING btree (team_id);


--
-- Name: IDX_dashboard_acl_user_id; Type: INDEX; Schema: public; Owner: grafana
--

CREATE INDEX "IDX_dashboard_acl_user_id" ON public.dashboard_acl USING btree (user_id);


--
-- Name: IDX_dashboard_gnet_id; Type: INDEX; Schema: public; Owner: grafana
--

CREATE INDEX "IDX_dashboard_gnet_id" ON public.dashboard USING btree (gnet_id);


--
-- Name: IDX_dashboard_is_folder; Type: INDEX; Schema: public; Owner: grafana
--

CREATE INDEX "IDX_dashboard_is_folder" ON public.dashboard USING btree (is_folder);


--
-- Name: IDX_dashboard_org_id; Type: INDEX; Schema: public; Owner: grafana
--

CREATE INDEX "IDX_dashboard_org_id" ON public.dashboard USING btree (org_id);


--
-- Name: IDX_dashboard_org_id_folder_id_title; Type: INDEX; Schema: public; Owner: grafana
--

CREATE INDEX "IDX_dashboard_org_id_folder_id_title" ON public.dashboard USING btree (org_id, folder_id, title);


--
-- Name: IDX_dashboard_org_id_plugin_id; Type: INDEX; Schema: public; Owner: grafana
--

CREATE INDEX "IDX_dashboard_org_id_plugin_id" ON public.dashboard USING btree (org_id, plugin_id);


--
-- Name: IDX_dashboard_provisioning_dashboard_id; Type: INDEX; Schema: public; Owner: grafana
--

CREATE INDEX "IDX_dashboard_provisioning_dashboard_id" ON public.dashboard_provisioning USING btree (dashboard_id);


--
-- Name: IDX_dashboard_provisioning_dashboard_id_name; Type: INDEX; Schema: public; Owner: grafana
--

CREATE INDEX "IDX_dashboard_provisioning_dashboard_id_name" ON public.dashboard_provisioning USING btree (dashboard_id, name);


--
-- Name: IDX_dashboard_public_config_org_id_dashboard_uid; Type: INDEX; Schema: public; Owner: grafana
--

CREATE INDEX "IDX_dashboard_public_config_org_id_dashboard_uid" ON public.dashboard_public USING btree (org_id, dashboard_uid);


--
-- Name: IDX_dashboard_snapshot_user_id; Type: INDEX; Schema: public; Owner: grafana
--

CREATE INDEX "IDX_dashboard_snapshot_user_id" ON public.dashboard_snapshot USING btree (user_id);


--
-- Name: IDX_dashboard_tag_dashboard_id; Type: INDEX; Schema: public; Owner: grafana
--

CREATE INDEX "IDX_dashboard_tag_dashboard_id" ON public.dashboard_tag USING btree (dashboard_id);


--
-- Name: IDX_dashboard_title; Type: INDEX; Schema: public; Owner: grafana
--

CREATE INDEX "IDX_dashboard_title" ON public.dashboard USING btree (title);


--
-- Name: IDX_dashboard_version_dashboard_id; Type: INDEX; Schema: public; Owner: grafana
--

CREATE INDEX "IDX_dashboard_version_dashboard_id" ON public.dashboard_version USING btree (dashboard_id);


--
-- Name: IDX_data_source_org_id; Type: INDEX; Schema: public; Owner: grafana
--

CREATE INDEX "IDX_data_source_org_id" ON public.data_source USING btree (org_id);


--
-- Name: IDX_data_source_org_id_is_default; Type: INDEX; Schema: public; Owner: grafana
--

CREATE INDEX "IDX_data_source_org_id_is_default" ON public.data_source USING btree (org_id, is_default);


--
-- Name: IDX_file_parent_folder_path_hash; Type: INDEX; Schema: public; Owner: grafana
--

CREATE INDEX "IDX_file_parent_folder_path_hash" ON public.file USING btree (parent_folder_path_hash);


--
-- Name: IDX_login_attempt_username; Type: INDEX; Schema: public; Owner: grafana
--

CREATE INDEX "IDX_login_attempt_username" ON public.login_attempt USING btree (username);


--
-- Name: IDX_org_user_org_id; Type: INDEX; Schema: public; Owner: grafana
--

CREATE INDEX "IDX_org_user_org_id" ON public.org_user USING btree (org_id);


--
-- Name: IDX_org_user_user_id; Type: INDEX; Schema: public; Owner: grafana
--

CREATE INDEX "IDX_org_user_user_id" ON public.org_user USING btree (user_id);


--
-- Name: IDX_permission_identifier; Type: INDEX; Schema: public; Owner: grafana
--

CREATE INDEX "IDX_permission_identifier" ON public.permission USING btree (identifier);


--
-- Name: IDX_permission_role_id; Type: INDEX; Schema: public; Owner: grafana
--

CREATE INDEX "IDX_permission_role_id" ON public.permission USING btree (role_id);


--
-- Name: IDX_preferences_org_id; Type: INDEX; Schema: public; Owner: grafana
--

CREATE INDEX "IDX_preferences_org_id" ON public.preferences USING btree (org_id);


--
-- Name: IDX_preferences_user_id; Type: INDEX; Schema: public; Owner: grafana
--

CREATE INDEX "IDX_preferences_user_id" ON public.preferences USING btree (user_id);


--
-- Name: IDX_query_history_org_id_created_by_datasource_uid; Type: INDEX; Schema: public; Owner: grafana
--

CREATE INDEX "IDX_query_history_org_id_created_by_datasource_uid" ON public.query_history USING btree (org_id, created_by, datasource_uid);


--
-- Name: IDX_role_org_id; Type: INDEX; Schema: public; Owner: grafana
--

CREATE INDEX "IDX_role_org_id" ON public.role USING btree (org_id);


--
-- Name: IDX_team_member_org_id; Type: INDEX; Schema: public; Owner: grafana
--

CREATE INDEX "IDX_team_member_org_id" ON public.team_member USING btree (org_id);


--
-- Name: IDX_team_member_team_id; Type: INDEX; Schema: public; Owner: grafana
--

CREATE INDEX "IDX_team_member_team_id" ON public.team_member USING btree (team_id);


--
-- Name: IDX_team_org_id; Type: INDEX; Schema: public; Owner: grafana
--

CREATE INDEX "IDX_team_org_id" ON public.team USING btree (org_id);


--
-- Name: IDX_team_role_org_id; Type: INDEX; Schema: public; Owner: grafana
--

CREATE INDEX "IDX_team_role_org_id" ON public.team_role USING btree (org_id);


--
-- Name: IDX_team_role_team_id; Type: INDEX; Schema: public; Owner: grafana
--

CREATE INDEX "IDX_team_role_team_id" ON public.team_role USING btree (team_id);


--
-- Name: IDX_temp_user_code; Type: INDEX; Schema: public; Owner: grafana
--

CREATE INDEX "IDX_temp_user_code" ON public.temp_user USING btree (code);


--
-- Name: IDX_temp_user_email; Type: INDEX; Schema: public; Owner: grafana
--

CREATE INDEX "IDX_temp_user_email" ON public.temp_user USING btree (email);


--
-- Name: IDX_temp_user_org_id; Type: INDEX; Schema: public; Owner: grafana
--

CREATE INDEX "IDX_temp_user_org_id" ON public.temp_user USING btree (org_id);


--
-- Name: IDX_temp_user_status; Type: INDEX; Schema: public; Owner: grafana
--

CREATE INDEX "IDX_temp_user_status" ON public.temp_user USING btree (status);


--
-- Name: IDX_user_auth_auth_module_auth_id; Type: INDEX; Schema: public; Owner: grafana
--

CREATE INDEX "IDX_user_auth_auth_module_auth_id" ON public.user_auth USING btree (auth_module, auth_id);


--
-- Name: IDX_user_auth_token_revoked_at; Type: INDEX; Schema: public; Owner: grafana
--

CREATE INDEX "IDX_user_auth_token_revoked_at" ON public.user_auth_token USING btree (revoked_at);


--
-- Name: IDX_user_auth_token_user_id; Type: INDEX; Schema: public; Owner: grafana
--

CREATE INDEX "IDX_user_auth_token_user_id" ON public.user_auth_token USING btree (user_id);


--
-- Name: IDX_user_auth_user_id; Type: INDEX; Schema: public; Owner: grafana
--

CREATE INDEX "IDX_user_auth_user_id" ON public.user_auth USING btree (user_id);


--
-- Name: IDX_user_login_email; Type: INDEX; Schema: public; Owner: grafana
--

CREATE INDEX "IDX_user_login_email" ON public."user" USING btree (login, email);


--
-- Name: IDX_user_role_org_id; Type: INDEX; Schema: public; Owner: grafana
--

CREATE INDEX "IDX_user_role_org_id" ON public.user_role USING btree (org_id);


--
-- Name: IDX_user_role_user_id; Type: INDEX; Schema: public; Owner: grafana
--

CREATE INDEX "IDX_user_role_user_id" ON public.user_role USING btree (user_id);


--
-- Name: UQE_alert_configuration_org_id; Type: INDEX; Schema: public; Owner: grafana
--

CREATE UNIQUE INDEX "UQE_alert_configuration_org_id" ON public.alert_configuration USING btree (org_id);


--
-- Name: UQE_alert_image_token; Type: INDEX; Schema: public; Owner: grafana
--

CREATE UNIQUE INDEX "UQE_alert_image_token" ON public.alert_image USING btree (token);


--
-- Name: UQE_alert_notification_org_id_uid; Type: INDEX; Schema: public; Owner: grafana
--

CREATE UNIQUE INDEX "UQE_alert_notification_org_id_uid" ON public.alert_notification USING btree (org_id, uid);


--
-- Name: UQE_alert_notification_state_org_id_alert_id_notifier_id; Type: INDEX; Schema: public; Owner: grafana
--

CREATE UNIQUE INDEX "UQE_alert_notification_state_org_id_alert_id_notifier_id" ON public.alert_notification_state USING btree (org_id, alert_id, notifier_id);


--
-- Name: UQE_alert_rule_org_id_namespace_uid_title; Type: INDEX; Schema: public; Owner: grafana
--

CREATE UNIQUE INDEX "UQE_alert_rule_org_id_namespace_uid_title" ON public.alert_rule USING btree (org_id, namespace_uid, title);


--
-- Name: UQE_alert_rule_org_id_uid; Type: INDEX; Schema: public; Owner: grafana
--

CREATE UNIQUE INDEX "UQE_alert_rule_org_id_uid" ON public.alert_rule USING btree (org_id, uid);


--
-- Name: UQE_alert_rule_tag_alert_id_tag_id; Type: INDEX; Schema: public; Owner: grafana
--

CREATE UNIQUE INDEX "UQE_alert_rule_tag_alert_id_tag_id" ON public.alert_rule_tag USING btree (alert_id, tag_id);


--
-- Name: UQE_alert_rule_version_rule_org_id_rule_uid_version; Type: INDEX; Schema: public; Owner: grafana
--

CREATE UNIQUE INDEX "UQE_alert_rule_version_rule_org_id_rule_uid_version" ON public.alert_rule_version USING btree (rule_org_id, rule_uid, version);


--
-- Name: UQE_annotation_tag_annotation_id_tag_id; Type: INDEX; Schema: public; Owner: grafana
--

CREATE UNIQUE INDEX "UQE_annotation_tag_annotation_id_tag_id" ON public.annotation_tag USING btree (annotation_id, tag_id);


--
-- Name: UQE_anon_device_device_id; Type: INDEX; Schema: public; Owner: grafana
--

CREATE UNIQUE INDEX "UQE_anon_device_device_id" ON public.anon_device USING btree (device_id);


--
-- Name: UQE_api_key_key; Type: INDEX; Schema: public; Owner: grafana
--

CREATE UNIQUE INDEX "UQE_api_key_key" ON public.api_key USING btree (key);


--
-- Name: UQE_api_key_org_id_name; Type: INDEX; Schema: public; Owner: grafana
--

CREATE UNIQUE INDEX "UQE_api_key_org_id_name" ON public.api_key USING btree (org_id, name);


--
-- Name: UQE_builtin_role_org_id_role_id_role; Type: INDEX; Schema: public; Owner: grafana
--

CREATE UNIQUE INDEX "UQE_builtin_role_org_id_role_id_role" ON public.builtin_role USING btree (org_id, role_id, role);


--
-- Name: UQE_cache_data_cache_key; Type: INDEX; Schema: public; Owner: grafana
--

CREATE UNIQUE INDEX "UQE_cache_data_cache_key" ON public.cache_data USING btree (cache_key);


--
-- Name: UQE_dashboard_acl_dashboard_id_team_id; Type: INDEX; Schema: public; Owner: grafana
--

CREATE UNIQUE INDEX "UQE_dashboard_acl_dashboard_id_team_id" ON public.dashboard_acl USING btree (dashboard_id, team_id);


--
-- Name: UQE_dashboard_acl_dashboard_id_user_id; Type: INDEX; Schema: public; Owner: grafana
--

CREATE UNIQUE INDEX "UQE_dashboard_acl_dashboard_id_user_id" ON public.dashboard_acl USING btree (dashboard_id, user_id);


--
-- Name: UQE_dashboard_org_id_folder_uid_title_is_folder; Type: INDEX; Schema: public; Owner: grafana
--

CREATE UNIQUE INDEX "UQE_dashboard_org_id_folder_uid_title_is_folder" ON public.dashboard USING btree (org_id, folder_uid, title, is_folder);


--
-- Name: UQE_dashboard_org_id_uid; Type: INDEX; Schema: public; Owner: grafana
--

CREATE UNIQUE INDEX "UQE_dashboard_org_id_uid" ON public.dashboard USING btree (org_id, uid);


--
-- Name: UQE_dashboard_public_config_access_token; Type: INDEX; Schema: public; Owner: grafana
--

CREATE UNIQUE INDEX "UQE_dashboard_public_config_access_token" ON public.dashboard_public USING btree (access_token);


--
-- Name: UQE_dashboard_public_config_uid; Type: INDEX; Schema: public; Owner: grafana
--

CREATE UNIQUE INDEX "UQE_dashboard_public_config_uid" ON public.dashboard_public USING btree (uid);


--
-- Name: UQE_dashboard_snapshot_delete_key; Type: INDEX; Schema: public; Owner: grafana
--

CREATE UNIQUE INDEX "UQE_dashboard_snapshot_delete_key" ON public.dashboard_snapshot USING btree (delete_key);


--
-- Name: UQE_dashboard_snapshot_key; Type: INDEX; Schema: public; Owner: grafana
--

CREATE UNIQUE INDEX "UQE_dashboard_snapshot_key" ON public.dashboard_snapshot USING btree (key);


--
-- Name: UQE_dashboard_version_dashboard_id_version; Type: INDEX; Schema: public; Owner: grafana
--

CREATE UNIQUE INDEX "UQE_dashboard_version_dashboard_id_version" ON public.dashboard_version USING btree (dashboard_id, version);


--
-- Name: UQE_data_source_org_id_name; Type: INDEX; Schema: public; Owner: grafana
--

CREATE UNIQUE INDEX "UQE_data_source_org_id_name" ON public.data_source USING btree (org_id, name);


--
-- Name: UQE_data_source_org_id_uid; Type: INDEX; Schema: public; Owner: grafana
--

CREATE UNIQUE INDEX "UQE_data_source_org_id_uid" ON public.data_source USING btree (org_id, uid);


--
-- Name: UQE_file_meta_path_hash_key; Type: INDEX; Schema: public; Owner: grafana
--

CREATE UNIQUE INDEX "UQE_file_meta_path_hash_key" ON public.file_meta USING btree (path_hash, key);


--
-- Name: UQE_file_path_hash; Type: INDEX; Schema: public; Owner: grafana
--

CREATE UNIQUE INDEX "UQE_file_path_hash" ON public.file USING btree (path_hash);


--
-- Name: UQE_folder_org_id_parent_uid_title; Type: INDEX; Schema: public; Owner: grafana
--

CREATE UNIQUE INDEX "UQE_folder_org_id_parent_uid_title" ON public.folder USING btree (org_id, parent_uid, title);


--
-- Name: UQE_folder_org_id_uid; Type: INDEX; Schema: public; Owner: grafana
--

CREATE UNIQUE INDEX "UQE_folder_org_id_uid" ON public.folder USING btree (org_id, uid);


--
-- Name: UQE_kv_store_org_id_namespace_key; Type: INDEX; Schema: public; Owner: grafana
--

CREATE UNIQUE INDEX "UQE_kv_store_org_id_namespace_key" ON public.kv_store USING btree (org_id, namespace, key);


--
-- Name: UQE_library_element_connection_element_id_kind_connection_id; Type: INDEX; Schema: public; Owner: grafana
--

CREATE UNIQUE INDEX "UQE_library_element_connection_element_id_kind_connection_id" ON public.library_element_connection USING btree (element_id, kind, connection_id);


--
-- Name: UQE_library_element_org_id_folder_id_name_kind; Type: INDEX; Schema: public; Owner: grafana
--

CREATE UNIQUE INDEX "UQE_library_element_org_id_folder_id_name_kind" ON public.library_element USING btree (org_id, folder_id, name, kind);


--
-- Name: UQE_library_element_org_id_uid; Type: INDEX; Schema: public; Owner: grafana
--

CREATE UNIQUE INDEX "UQE_library_element_org_id_uid" ON public.library_element USING btree (org_id, uid);


--
-- Name: UQE_ngalert_configuration_org_id; Type: INDEX; Schema: public; Owner: grafana
--

CREATE UNIQUE INDEX "UQE_ngalert_configuration_org_id" ON public.ngalert_configuration USING btree (org_id);


--
-- Name: UQE_org_name; Type: INDEX; Schema: public; Owner: grafana
--

CREATE UNIQUE INDEX "UQE_org_name" ON public.org USING btree (name);


--
-- Name: UQE_org_user_org_id_user_id; Type: INDEX; Schema: public; Owner: grafana
--

CREATE UNIQUE INDEX "UQE_org_user_org_id_user_id" ON public.org_user USING btree (org_id, user_id);


--
-- Name: UQE_permission_action_scope_role_id; Type: INDEX; Schema: public; Owner: grafana
--

CREATE UNIQUE INDEX "UQE_permission_action_scope_role_id" ON public.permission USING btree (action, scope, role_id);


--
-- Name: UQE_playlist_org_id_uid; Type: INDEX; Schema: public; Owner: grafana
--

CREATE UNIQUE INDEX "UQE_playlist_org_id_uid" ON public.playlist USING btree (org_id, uid);


--
-- Name: UQE_plugin_setting_org_id_plugin_id; Type: INDEX; Schema: public; Owner: grafana
--

CREATE UNIQUE INDEX "UQE_plugin_setting_org_id_plugin_id" ON public.plugin_setting USING btree (org_id, plugin_id);


--
-- Name: UQE_provenance_type_record_type_record_key_org_id; Type: INDEX; Schema: public; Owner: grafana
--

CREATE UNIQUE INDEX "UQE_provenance_type_record_type_record_key_org_id" ON public.provenance_type USING btree (record_type, record_key, org_id);


--
-- Name: UQE_query_history_star_user_id_query_uid; Type: INDEX; Schema: public; Owner: grafana
--

CREATE UNIQUE INDEX "UQE_query_history_star_user_id_query_uid" ON public.query_history_star USING btree (user_id, query_uid);


--
-- Name: UQE_quota_org_id_user_id_target; Type: INDEX; Schema: public; Owner: grafana
--

CREATE UNIQUE INDEX "UQE_quota_org_id_user_id_target" ON public.quota USING btree (org_id, user_id, target);


--
-- Name: UQE_role_org_id_name; Type: INDEX; Schema: public; Owner: grafana
--

CREATE UNIQUE INDEX "UQE_role_org_id_name" ON public.role USING btree (org_id, name);


--
-- Name: UQE_role_uid; Type: INDEX; Schema: public; Owner: grafana
--

CREATE UNIQUE INDEX "UQE_role_uid" ON public.role USING btree (uid);


--
-- Name: UQE_seed_assignment_builtin_role_action_scope; Type: INDEX; Schema: public; Owner: grafana
--

CREATE UNIQUE INDEX "UQE_seed_assignment_builtin_role_action_scope" ON public.seed_assignment USING btree (builtin_role, action, scope);


--
-- Name: UQE_seed_assignment_builtin_role_role_name; Type: INDEX; Schema: public; Owner: grafana
--

CREATE UNIQUE INDEX "UQE_seed_assignment_builtin_role_role_name" ON public.seed_assignment USING btree (builtin_role, role_name);


--
-- Name: UQE_server_lock_operation_uid; Type: INDEX; Schema: public; Owner: grafana
--

CREATE UNIQUE INDEX "UQE_server_lock_operation_uid" ON public.server_lock USING btree (operation_uid);


--
-- Name: UQE_short_url_org_id_uid; Type: INDEX; Schema: public; Owner: grafana
--

CREATE UNIQUE INDEX "UQE_short_url_org_id_uid" ON public.short_url USING btree (org_id, uid);


--
-- Name: UQE_signing_key_key_id; Type: INDEX; Schema: public; Owner: grafana
--

CREATE UNIQUE INDEX "UQE_signing_key_key_id" ON public.signing_key USING btree (key_id);


--
-- Name: UQE_star_user_id_dashboard_id; Type: INDEX; Schema: public; Owner: grafana
--

CREATE UNIQUE INDEX "UQE_star_user_id_dashboard_id" ON public.star USING btree (user_id, dashboard_id);


--
-- Name: UQE_tag_key_value; Type: INDEX; Schema: public; Owner: grafana
--

CREATE UNIQUE INDEX "UQE_tag_key_value" ON public.tag USING btree (key, value);


--
-- Name: UQE_team_member_org_id_team_id_user_id; Type: INDEX; Schema: public; Owner: grafana
--

CREATE UNIQUE INDEX "UQE_team_member_org_id_team_id_user_id" ON public.team_member USING btree (org_id, team_id, user_id);


--
-- Name: UQE_team_org_id_name; Type: INDEX; Schema: public; Owner: grafana
--

CREATE UNIQUE INDEX "UQE_team_org_id_name" ON public.team USING btree (org_id, name);


--
-- Name: UQE_team_org_id_uid; Type: INDEX; Schema: public; Owner: grafana
--

CREATE UNIQUE INDEX "UQE_team_org_id_uid" ON public.team USING btree (org_id, uid);


--
-- Name: UQE_team_role_org_id_team_id_role_id; Type: INDEX; Schema: public; Owner: grafana
--

CREATE UNIQUE INDEX "UQE_team_role_org_id_team_id_role_id" ON public.team_role USING btree (org_id, team_id, role_id);


--
-- Name: UQE_user_auth_token_auth_token; Type: INDEX; Schema: public; Owner: grafana
--

CREATE UNIQUE INDEX "UQE_user_auth_token_auth_token" ON public.user_auth_token USING btree (auth_token);


--
-- Name: UQE_user_auth_token_prev_auth_token; Type: INDEX; Schema: public; Owner: grafana
--

CREATE UNIQUE INDEX "UQE_user_auth_token_prev_auth_token" ON public.user_auth_token USING btree (prev_auth_token);


--
-- Name: UQE_user_email; Type: INDEX; Schema: public; Owner: grafana
--

CREATE UNIQUE INDEX "UQE_user_email" ON public."user" USING btree (email);


--
-- Name: UQE_user_login; Type: INDEX; Schema: public; Owner: grafana
--

CREATE UNIQUE INDEX "UQE_user_login" ON public."user" USING btree (login);


--
-- Name: UQE_user_role_org_id_user_id_role_id; Type: INDEX; Schema: public; Owner: grafana
--

CREATE UNIQUE INDEX "UQE_user_role_org_id_user_id_role_id" ON public.user_role USING btree (org_id, user_id, role_id);


--
-- Name: UQE_user_uid; Type: INDEX; Schema: public; Owner: grafana
--

CREATE UNIQUE INDEX "UQE_user_uid" ON public."user" USING btree (uid);


--
-- PostgreSQL database dump complete
--

COMMIT;