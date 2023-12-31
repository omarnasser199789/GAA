const { spawn } = require('child_process');

// Run the command
const childProcess = spawn('mason', ['make', 'acadimiat', '--app_name', 'Felix'], { stdio: 'inherit' });

// Listen for the exit event of the command
childProcess.on('exit', (code, signal) => {
    if (code !== 0) {
        console.error(`Command failed with exit code ${code}`);
    } else {
        console.log('Command succeeded');
    }
});
