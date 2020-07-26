# Self-elevate the script if required
if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
  $CommandLine = "-File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
  Start-Process -FilePath PowerShell.exe -Verb Runas -ArgumentList $CommandLine
  Exit
}

# Install chocolatey
if (-Not (choco --version)) {
  Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
} else {
  choco upgrade chocolatey -y
}

# Create list of all packages to install
if (-Not ($args -contains "less")) {
  $packages = @("neovim", "git", "python", "python2", "firefox", "gradle", "groovy", "utorrent", "paint.net")
} else {
  $packages = @("firefox")
}
foreach ($arg in $args) {
  switch ($arg) {
    "node" { $packages += @("nodejs", "yarn") }
    "vim" {
      $packages = $packages | where {$_ -ne "neovim"}
      $packages += "vim"
    }
    "neovim" {
      if (-Not ($packages -contains "neovim")) {
        $packages += "neovim"
      }
    }
    "torrent" {
      $packages += "utorrent"
    }
    "git" {
      $packages += "git"
    }
    "paint" {
      $packages += "paint.net"
    }
  }
}

# Install Choco Packages
foreach ($package in $packages) {
  if (-Not (choco list -localonly | Select-String -Pattern $package)) {
    choco install $package -y
  } else {
    choco upgrade $package -y
  }
}

if ($packages -contains "neovim") {
  md ~\AppData\Local\nvim-data\site\autoload
  $uri = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  (New-Object Net.WebClient).DownloadFile(
    $uri,
    $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath(
      "~\AppData\Local\nvim-data\site\autoload\plug.vim"
    )
  )
}

if ($packages -contains "vim") {
  md ~\vimfiles\autoload
  $uri = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  (New-Object Net.WebClient).DownloadFile(
    $uri,
    $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath(
      "~\vimfiles\autoload\plug.vim"
    )
  )
}

# TODO:
# Install Docker?
# not with choco
# Install TeX
# Install JDK (newest)
# Install JRE (1.8/ 1.11)

sleep 10
