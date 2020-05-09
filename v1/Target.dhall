{-

A "compilation target".

Every target can have its own dependencies, source globs, etc.
By convention a package needs to have at least one target called `lib`.

Other common ones are `app`, `test`, `dev`, `bench`, etc. 

-}

let Map = (./Prelude.dhall).Map.Type

let TargetType =
      -- A mapping between package names (as published on the Registry or
      -- included in the Package Set) and SemVer ranges for them.
      { dependencies : Map Text Text
      -- Source globs for the local project to include in the compilation
      -- alongside its dependencies.
      , sources : List Text
      -- Optional output folder where the compiler will put its result.
      -- If not specified, the compiler will use "output"
      , output : Optional Text
      -- A target might not be pointing at the JS backend - if that's the case
      -- we can specify here the command for the alternate backend.
      -- Example values: `psgo`, `pskt`, etc.
      , backend : Optional Text
      -- A mapping between native package names and their versions in a format
      -- understood by the backend specific tool used to install them.
      , nativeDependencies : Map Text Text
      }

let default =
      { dependencies = (toMap {=}) : Map Text Text
      , sources = [] : List Text
      , output = None Text
      , backend = None Text
      , nativeDependencies = (toMap {=}) : Map Text Text
      }

in  { default = default, Type = TargetType }