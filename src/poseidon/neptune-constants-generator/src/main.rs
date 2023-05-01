use std::process::exit;
use neptune::hash_type::HashType;
use neptune::poseidon::PoseidonConstants;
use neptune::Strength;
use blstrs::Scalar as Fr;
use clap::Parser;
use generic_array::typenum::U24;
use serde_json::json;
use std::fmt::Write;
use std::path::{Path, PathBuf};

#[derive(Parser, Debug)]
#[command(author, version, about, long_about = None)]
struct Cli {
    #[arg(short, long, default_value = "standard")]
    security_level: String,

    #[arg(short, long, default_value = "sponge")]
    hash_type: String,

    #[arg(short, long)]
    out_json_path: Option<PathBuf>,
}

fn main() {
    let cli = Cli::parse();

    let security_level: Strength = match cli.security_level.as_str() {
        "standard" => Strength::Standard,
        "strengthened" => Strength::Strengthened,
        _ => {
            println!("two security levels are supported currently: 'standard' and 'strengthened'");
            exit(1);
        }
    };

    let hash_type = match cli.hash_type.as_str() {
        "encryption" => HashType::Encryption,
        "sponge" => HashType::Sponge,
        _ => {
            println!("two security levels are supported currently: 'encryption' and 'sponge'");
            exit(1);
        }
    };

    let out_json_path = match cli.out_json_path.as_deref() {
        Some(out_json_path) => out_json_path,
        None => Path::new(".")
    };

    // TODO: add state_size configuring with a help of additional cli flag
    type Arity = U24;
    // state_size equals to Arity + 1
    let state_size = 25usize;

    let constants: PoseidonConstants<Fr, Arity> =
        PoseidonConstants::new_with_strength_and_type(security_level, hash_type.clone());


    let round_constants = constants.round_constants.clone().unwrap().into_iter().map(|scalar| {
       format_scalar(scalar)
    }).collect::<Vec<String>>();

    let matrix_m = constants.mds_matrices.m.clone().into_iter().map(|m_row| {
        m_row.into_iter().map(|scalar| {
            format_scalar(scalar)
        }).collect::<Vec<String>>()
    }).collect::<Vec<Vec<String>>>();

    let constants_serialized = json!({
        "state_size_field_elements": state_size,
        "full_rounds": constants.full_rounds,
        "partial_rounds": constants.partial_rounds,
        "round_constants": &round_constants,
        "matrix_M": &matrix_m
    });

    std::fs::write(out_json_path, constants_serialized.to_string()).expect("Unable to write file");

    println!("security_level: {:?}", security_level);
    println!("hash_type: {:?}", hash_type);
    println!("output JSON path: {:?}", std::fs::canonicalize(out_json_path));

    exit(0);
}

fn format_scalar(scalar: Fr) -> String {
    let mut scalar_string = String::new();
    let be_bytes = scalar.to_bytes_be();
    write!(scalar_string, "0x").unwrap();
    for &b in be_bytes.iter() {
        write!(scalar_string, "{:02x}", b).unwrap();
    }
    scalar_string
}
