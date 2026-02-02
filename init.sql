
--  domain 
CREATE TABLE IF NOT EXISTS domain (
    domain varchar(255) NOT NULL,
    a_record varchar(255) NOT NULL DEFAULT '',
    mailboxes int NOT NULL DEFAULT 50,                       -- Number of emails created
    mailbox_quota BIGINT NOT NULL DEFAULT 5368709120,        -- Default space size of mailbox
    quota BIGINT NOT NULL DEFAULT 10737418240,               -- Domain name quota
    rate_limit INT DEFAULT 12,                               -- How many emails per second
    create_time INT NOT NULL default 0,
    active SMALLINT NOT NULL DEFAULT 1,
    PRIMARY KEY (domain)
);

--  mailbox 
CREATE TABLE IF NOT EXISTS mailbox (
    username varchar(255) NOT NULL,
    password varchar(255) NOT NULL,
    password_encode varchar(255) NOT NULL,
    full_name varchar(255) NOT NULL,
    is_admin smallint NOT NULL DEFAULT 0,
    maildir varchar(255) NOT NULL,
    quota bigint NOT NULL DEFAULT 0,
    local_part varchar(255) NOT NULL,
    domain varchar(255) NOT NULL,
    create_time int NOT NULL default 0,
    update_time int NOT NULL default 0,
    active SMALLINT NOT NULL DEFAULT 1,
    PRIMARY KEY (username)
);

--  alias 
CREATE TABLE IF NOT EXISTS alias (
    address varchar(255) NOT NULL,
    goto text NOT NULL,
    domain varchar(255) NOT NULL,
    create_time int NOT NULL default 0,
    update_time int NOT NULL default 0,
    active smallint NOT NULL DEFAULT 1,
    PRIMARY KEY (address)
);

--  alias_domain 
CREATE TABLE IF NOT EXISTS alias_domain (
    alias_domain varchar(255) NOT NULL, 
    target_domain varchar(255) NOT NULL,
    create_time int NOT NULL default 0,
    update_time int NOT NULL default 0,
    active smallint NOT NULL DEFAULT 1,
    PRIMARY KEY (alias_domain)
);


-- IP Rotation configuration for multi-IP VPS email sending
CREATE TABLE IF NOT EXISTS bm_ip_rotation_config (
    id SERIAL PRIMARY KEY,
    enabled INTEGER DEFAULT 0,
    ips TEXT DEFAULT '',
    emails_per_ip INTEGER DEFAULT 3000,
    current_ip_index INTEGER DEFAULT 0,
    total_emails_sent BIGINT DEFAULT 0,
    last_rotation BIGINT DEFAULT 0,
    create_time BIGINT DEFAULT 0,
    update_time BIGINT DEFAULT 0
);
