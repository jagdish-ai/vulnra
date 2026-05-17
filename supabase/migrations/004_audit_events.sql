-- VULNRA — Audit Events Table
-- Part of the Lobster Trap integration: unifies intercept events and scan
-- results into a single queryable audit trail for compliance reporting.
--
-- Migration 004: run after 003_intercept_events.sql

create table if not exists audit_events (
    id uuid primary key default gen_random_uuid(),
    scan_id uuid references scans(id) on delete set null,
    org_id uuid references organizations(id) on delete set null,
    event_type text not null,
    timestamp timestamptz not null default now(),
    actor text,
    target text,
    outcome text,
    risk_score float,
    owasp_category text,
    compliance_tags text[],
    metadata jsonb,
    created_at timestamptz default now()
);

create index if not exists idx_audit_events_scan_id on audit_events(scan_id);
create index if not exists idx_audit_events_org_id on audit_events(org_id);
create index if not exists idx_audit_events_event_type on audit_events(event_type);
create index if not exists idx_audit_events_timestamp on audit_events(timestamp desc);
