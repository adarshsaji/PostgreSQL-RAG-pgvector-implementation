-- Enable pgvector extension
CREATE EXTENSION IF NOT EXISTS vector;

BEGIN;

-- Create the document_status table
CREATE TABLE document_status (
    status_id SERIAL PRIMARY KEY,
    status_name VARCHAR(100) UNIQUE NOT NULL,
    description TEXT
);

-- Create the documents table
CREATE TABLE documents (
    document_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    file_name VARCHAR(255) NOT NULL,
    file_format VARCHAR(50) NOT NULL,
    document_data BYTEA,
    status_id INT REFERENCES document_status(status_id),
    version INT NOT NULL DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create the parsed_data table
CREATE TABLE parsed_data (
    parsed_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    document_id UUID REFERENCES documents(document_id) ON DELETE CASCADE,
    chunk_id INT NOT NULL,
    content TEXT NOT NULL,
    version INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create the vector_embeddings table
CREATE TABLE vector_embeddings (
    embedding_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    parsed_id UUID REFERENCES parsed_data(parsed_id) ON DELETE CASCADE,
    chunk_id INT NOT NULL,
    embedding VECTOR(512) NOT NULL, -- Assuming a 512-dimensional vector
    version INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create the query_logs table
CREATE TABLE query_logs (
    query_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    query_text TEXT NOT NULL,
    query_embedding VECTOR(512) NOT NULL, -- Assuming a 512-dimensional vector
    result_ids UUID[] NOT NULL, -- Array of UUIDs
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert initial statuses into document_status table
INSERT INTO document_status (status_name, description)
VALUES
    ('Uploaded', 'Document has been uploaded.'),
    ('Processed', 'Document has been processed.'),
    ('Error', 'Error occurred while processing the document.');

COMMIT;

-- Add indexes for performance
CREATE INDEX idx_document_status ON documents(status_id);
CREATE INDEX idx_parsed_data_document_id ON parsed_data(document_id);
CREATE INDEX idx_vector_embeddings_parsed_id ON vector_embeddings(parsed_id);
