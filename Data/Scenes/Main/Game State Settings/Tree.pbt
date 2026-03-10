Name: "Game State Settings"
RootId: 5319993707169886532
Objects {
  Id: 9539352372659281016
  Name: "Racing Round"
  Transform {
    Scale {
      X: 1
      Y: 1
      Z: 1
    }
  }
  ParentId: 5319993707169886532
  Collidable_v2 {
    Value: "mc:ecollisionsetting:inheritfromparent"
  }
  Visible_v2 {
    Value: "mc:evisibilitysetting:inheritfromparent"
  }
  TemplateInstance {
    ParameterOverrideMap {
      key: 17994909708998495860
      value {
        Overrides {
          Name: "Name"
          String: "Racing Round"
        }
        Overrides {
          Name: "Position"
          Vector {
            X: -800
            Y: -9750
            Z: 125
          }
        }
        Overrides {
          Name: "Rotation"
          Rotator {
          }
        }
        Overrides {
          Name: "cs:RoundEndCountdownTime"
          Float: 15
        }
        Overrides {
          Name: "Scale"
          Vector {
            X: 1
            Y: 1
            Z: 1
          }
        }
      }
    }
    TemplateAsset {
      Id: 9007709654856949538
    }
  }
  NetworkRelevanceDistance {
    Value: "mc:eproxyrelevance:critical"
  }
  IsReplicationEnabledByDefault: true
}
Objects {
  Id: 7504716701439099630
  Name: "Lobby Required Players"
  Transform {
    Scale {
      X: 1
      Y: 1
      Z: 1
    }
  }
  ParentId: 5319993707169886532
  Collidable_v2 {
    Value: "mc:ecollisionsetting:inheritfromparent"
  }
  Visible_v2 {
    Value: "mc:evisibilitysetting:inheritfromparent"
  }
  TemplateInstance {
    ParameterOverrideMap {
      key: 4494359131020210007
      value {
        Overrides {
          Name: "Name"
          String: "Lobby Required Players"
        }
        Overrides {
          Name: "Scale"
          Vector {
            X: 1
            Y: 1
            Z: 1
          }
        }
        Overrides {
          Name: "cs:RequiredPlayers"
          Int: 1
        }
        Overrides {
          Name: "cs:CountdownTime"
          Float: 30
        }
      }
    }
    TemplateAsset {
      Id: 6847373455439933854
    }
  }
  NetworkRelevanceDistance {
    Value: "mc:eproxyrelevance:critical"
  }
  IsReplicationEnabledByDefault: true
}
Objects {
  Id: 16556974644680864160
  Name: "Basic Game State Manager"
  Transform {
    Scale {
      X: 1
      Y: 1
      Z: 1
    }
  }
  ParentId: 5319993707169886532
  Collidable_v2 {
    Value: "mc:ecollisionsetting:inheritfromparent"
  }
  Visible_v2 {
    Value: "mc:evisibilitysetting:inheritfromparent"
  }
  TemplateInstance {
    ParameterOverrideMap {
      key: 16086570097188718822
      value {
        Overrides {
          Name: "Name"
          String: "Basic Game State Manager"
        }
        Overrides {
          Name: "Scale"
          Vector {
            X: 1
            Y: 1
            Z: 1
          }
        }
        Overrides {
          Name: "cs:RoundDuration"
          Float: 300
        }
        Overrides {
          Name: "cs:RoundHasDuration"
          Bool: false
        }
      }
    }
    TemplateAsset {
      Id: 6691936407477998301
    }
  }
  NetworkRelevanceDistance {
    Value: "mc:eproxyrelevance:critical"
  }
  IsReplicationEnabledByDefault: true
}
