class hp_sdr::keys (
  $gpg_key1      = $hp_sdr::params::gpg_key1,
  $gpg_key1_path = $hp_sdr::params::gpg_key1_path,
  $gpg_key1_id   = $hp_sdr::params::gpg_key1_id,
  $gpg_key2      = $hp_sdr::params::gpg_key2,
  $gpg_key2_path = $hp_sdr::params::gpg_key2_path,
  $gpg_key2_id   = $hp_sdr::params::gpg_key2_id,
  $gpg_key3      = $hp_sdr::params::gpg_key3,
  $gpg_key3_path = $hp_sdr::params::gpg_key3_path,
  $gpg_key3_id   = $hp_sdr::params::gpg_key3_id
) inherits hp_sdr::params {

  validate_string($gpg_key1, $gpg_key1_id)
  validate_string($gpg_key2, $gpg_key2_id)
  validate_string($gpg_key3, $gpg_key3_id)

  case $::osfamily {
    redhat,suse: {
      validate_absolute_path($gpg_key1_path, $gpg_key2_path, $gpg_key3_path)

      yum::gpgkey { $gpg_key1_path:
        content => $gpg_key1,
      }

      yum::gpgkey { $gpg_key2_path:
        content => $gpg_key2,
      }

      yum::gpgkey { $gpg_key3_path:
        content => $gpg_key3,
      }
    }

    debian,ubuntu: {
      apt::key { 'hpPublicKey1':
        id      => $gpg_key1_id,
        content => $gpg_key1,
      }

      apt::key { 'hpPublicKey2':
        id      => $gpg_key2_id,
        content => $gpg_key2,
      }

      apt::key { 'hpPublicKey3':
        id      => $gpg_key3_id,
        content => $gpg_key3,
      }
    }

    default: {
      fail("Unsupported OS family: ${::osfamily}")
    }
  }
}
