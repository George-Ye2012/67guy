module.exports = {
  apps: [{
    name: '67guy',
    script: 'server.js',
    instances: 1,
    exec_mode: 'fork',
    env: {
      NODE_ENV: 'production',
      PORT: 3000
    },
    // Auto restart on crash
    autorestart: true,
    max_restarts: 10,
    restart_delay: 5000,
    // Log settings
    log_date_format: 'YYYY-MM-DD HH:mm:ss',
    error_file: './logs/error.log',
    out_file: './logs/out.log',
    merge_logs: true,
    // Watch for file changes (disable in production)
    watch: false,
    // Ignore data directory changes
    ignore_watch: ['node_modules', 'data', 'logs', '.git']
  }]
};
