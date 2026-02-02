-- Migration script for IP Rotation feature
-- This creates the table to store IP rotation configuration

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

-- Insert default configuration if not exists
INSERT INTO bm_ip_rotation_config (id, enabled, ips, emails_per_ip, current_ip_index, total_emails_sent, last_rotation, create_time, update_time)
VALUES (1, 0, '', 3000, 0, 0, 0, EXTRACT(EPOCH FROM NOW())::BIGINT, EXTRACT(EPOCH FROM NOW())::BIGINT)
ON CONFLICT (id) DO NOTHING;

-- Add comment
COMMENT ON TABLE bm_ip_rotation_config IS 'IP Rotation configuration for multi-IP VPS email sending';
COMMENT ON COLUMN bm_ip_rotation_config.enabled IS 'Whether IP rotation is enabled (0=disabled, 1=enabled)';
COMMENT ON COLUMN bm_ip_rotation_config.ips IS 'Comma-separated list of IPs for rotation';
COMMENT ON COLUMN bm_ip_rotation_config.emails_per_ip IS 'Number of emails to send before rotating to next IP';
COMMENT ON COLUMN bm_ip_rotation_config.current_ip_index IS 'Current IP index in the rotation';
COMMENT ON COLUMN bm_ip_rotation_config.total_emails_sent IS 'Total emails sent across all IPs';
COMMENT ON COLUMN bm_ip_rotation_config.last_rotation IS 'Unix timestamp of last IP rotation';
