(module config.plugin
  {autoload {nvim aniseed.nvim
             a aniseed.core
             util config.util
             packer packer}})

(defn safe-require-plugin-config [name]
  (let [(ok? val-or-err) (pcall require (.. :config.plugin. name))]
    (when (not ok?)
      (print (.. "config error: " val-or-err)))))

(defn- use [...]
  "Iterates through the arguments as pairs and calls packer's use function for
  each of them. Works around Fennel not liking mixed associative and sequential
  tables as well."
  (let [pkgs [...]]
    (packer.startup
      (fn [use]
        (for [i 1 (a.count pkgs) 2]
          (let [name (. pkgs i)
                opts (. pkgs (+ i 1))]
            (-?> (. opts :mod) (safe-require-plugin-config))
            (use (a.assoc opts 1 name))))))))

;plugins managed by packer
(use
  ;plugin Manager
  :wbthomason/packer.nvim {}
  ;nvim config and plugins in Fennel
  :Olical/aniseed {:branch :develop}
  ;theme
  :rafaeldelboni/novum.vim {:mod :theme}
  :ryanoasis/vim-devicons {}
  ;status line
  :hoob3rt/lualine.nvim {:mod :lualine}
  ;file exploration
  :preservim/nerdtree {:mod :nerdtree}
  :Xuyuanp/nerdtree-git-plugin {}
  ;commeting code
  :preservim/nerdcommenter {}
  ;clojure
  :Olical/conjure {:mod :conjure}
  )
