Assets {
  Id: 7285109856970203044
  Name: "Shared Material Race Track Showroom Plasma Roof"
  PlatformAssetType: 13
  SerializationVersion: 125
  CustomMaterialAsset {
    BaseMaterialId: 8594750810445795689
    ParameterOverrides {
      Overrides {
        Name: "outer color"
        Color {
          R: 0.110000014
          G: 0.717086
          B: 1
          A: 1
        }
      }
      Overrides {
        Name: "plasma inner color"
        Color {
          A: 1
        }
      }
      Overrides {
        Name: "plasma outer color"
        Color {
          R: 1
          G: 1
          B: 1
          A: 1
        }
      }
      Overrides {
        Name: "speed"
        Vector {
          X: -4.53981829
          Y: -5.57992649
          Z: 1.61483383
        }
      }
      Overrides {
        Name: "fresnel exponent"
        Float: 10
      }
      Overrides {
        Name: "threshold max"
        Float: 0.113864839
      }
      Overrides {
        Name: "inner color"
        Color {
          A: 1
        }
      }
      Overrides {
        Name: "plasma scale"
        Float: 114.655174
      }
    }
    Assets {
      Id: 8594750810445795689
      Name: "Plasma"
      PlatformAssetType: 2
      PrimaryAsset {
        AssetType: "MaterialAssetRef"
        AssetId: "fxma_plasmafield"
      }
    }
  }
}
